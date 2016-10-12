//
//  QuestionModel.swift
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
    "interview-questions": "5/interview-questions"
]

let questionListPattern = "^/category/(\\d+)/(\\S+)"

class QuestionListModel: NSObject {
    var title: String?
    var href: String?
    var questiongId: String?
    var urlName: String?
    var backgroundColorHex: String?
    
    init(rootNode: JiNode) {
        super.init()
        title = rootNode.xPath("./div/h2[@class='title']/a").first?.content?.trimmingCharacters(in: .whitespacesAndNewlines)
        href  = rootNode.xPath("./div/h2[@class='title']/a").first?["href"]
        if let hrefString = href {
            let groups = getGroups(in: hrefString, with: questionListPattern)
            questiongId = groups[1]
            urlName = groups[2]
        }
        // TODO: background-color
    }
    
    // MARK - Model Related Request
    class func requestList(
        category: String?,
        completionHandler: @escaping (LCXValueResponse<[QuestionListModel]>) -> Void
    ) {
        var params = [String: String]()
        params["category"] = category ?? "oj"
        let url = LeetCodeDiscussURL + "category/" + categoryDictionary[params["category"]!]!
        
        Alamofire.request(url).responseJiHtml { (response) -> Void in
            var questionList = [QuestionListModel]()
            if let jiHtml = response.result.value {
                if let rootNodes = jiHtml.xPath("//div[@class='subcategory']/ul[@class='categories']/li"){
                    for node in rootNodes {
                        let topic = QuestionListModel(rootNode: node)
                        questionList.append(topic);
                    }
                }
            }
            
            let t = LCXValueResponse<[QuestionListModel]>(value: questionList, success: response.result.isSuccess)
            completionHandler(t);
        }
    }
    
}
