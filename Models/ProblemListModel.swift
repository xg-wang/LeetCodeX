//
//  ProblemModel.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Ji

// TODO: need this?
let categoryDictionary: [String: String] = [
    "oj": "8/oj",
    "interview-problems": "5/interview-problems"
]

let problemListPattern = "^/category/(\\d+)/(\\S+)"

class ProblemListModel: NSObject {
    var title: String?
    var href: String?
    var problemgId: String?
    var urlName: String?
    var backgroundColorHex: String?
    
    init(rootNode: JiNode) {
        super.init()
        title = rootNode.xPath("./div/h2[@class='title']/a").first?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
        href  = rootNode.xPath("./div/h2[@class='title']/a").first?["href"]
        if let hrefString = href {
            let groups = getGroups(in: hrefString, with: problemListPattern)
            problemgId = groups[1]
            urlName = groups[2]
        }
        // TODO: background-color
    }
    
    // MARK - Model Related Request
    class func requestList(
        category: String?,
        completionHandler: @escaping (LCXValueResponse<[ProblemListModel]>) -> Void
    ) {
        var params = [String: String]()
        params["category"] = category ?? "oj"
        let url = LeetCodeDiscussURL + "category/" + categoryDictionary[params["category"]!]!
        
        Alamofire.request(url).responseJiHtml { (response) -> Void in
            var problemList = [ProblemListModel]()
            if let jiHtml = response.result.value {
                if let rootNodes = jiHtml.xPath("//div[@class='subcategory']/ul[@class='categories']/li"){
                    for node in rootNodes {
                        let topic = ProblemListModel(rootNode: node)
                        problemList.append(topic)
                    }
                }
            }
            
            let t = LCXValueResponse<[ProblemListModel]>(value: problemList, success: response.result.isSuccess)
            completionHandler(t);
        }
    }
    
}
