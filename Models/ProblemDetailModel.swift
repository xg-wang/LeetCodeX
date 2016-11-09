//
//  ProblemDetail.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/12/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Ji

let metaDataPattern = "(\\S+)$"
let htmlExtractContentPattern = "([\\s\\S]+)<div>\n\\s+<p><a href=\"/subscribe/\">Subscribe</a>"

struct Tag {
    var name: String
    var href: String
    init(name: String, href: String) {
        self.name = name
        self.href = href
    }
}

class ProblemDetailModel: NSObject {
    var title: String?
    var HTMLcontent: String?
    var tags = [Tag]()
    var similarProblems = [Tag]()
    var totalAccepted: String?
    var totalSubmitted: String?
    var difficulty: String?
    
    init(rootNode: JiNode) {
        super.init()
        // Parse content
        if let htmlString = rootNode.xPath("./div[@class='question-content']").first?.rawContent {
            let HTMLGroups = getGroups(in: htmlString, with: htmlExtractContentPattern)
            HTMLcontent = HTMLGroups[1]
        }
        // Parse tags
        let tagNodes = rootNode.xPath(".//span[@class='hidebutton']/a")
        for tagNode in tagNodes {
            if let href = tagNode["href"], let name = tagNode.content {
                if href.hasPrefix("/tag") {
                    let tag = Tag(name: name, href: href)
                    tags.append(tag)
                } else {
                    let tag = Tag(name: name, href: href)
                    similarProblems.append(tag)
                }
            }
        }
        
        // Parse metadata
        let metaData = rootNode.xPath("./div[@class='question-info text-info']//li")
        if metaData.count > 3 {
            totalAccepted = getGroups(in: metaData[0].content!, with: metaDataPattern).first
            totalSubmitted = getGroups(in: metaData[1].content!, with: metaDataPattern).first
            difficulty = getGroups(in: metaData[2].content!, with: metaDataPattern).first
        }
    }
    
    // MARK - Model Related Request
    class func requestDetail(
        urlName: String,
        completionHandler: @escaping (LCXValueResponse<ProblemDetailModel>) -> Void
    ) {
        let url = LeetCodeProblemsURL + urlName
        
        Alamofire.request(url).responseJiHtml { (response) -> Void in
            var problemDetails = [ProblemDetailModel]()
            if let jiHtml = response.result.value {
                if let rootNodes = jiHtml.xPath("//div[@class='container']/div[@class='row']/div[@class='col-md-12']/div[@class='row']/div"){
                    for node in rootNodes {
                        let problem = ProblemDetailModel(rootNode: node)
                        problemDetails.append(problem)
                    }
                }
            }
            
            if let problem = problemDetails.first {
                let t = LCXValueResponse<ProblemDetailModel>(value: problem, success: response.result.isSuccess)
                completionHandler(t);
            }
        }
    }
    
}
