//
//  DiscussionModel.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/12/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation
import Ji
import Alamofire

class DiscussionModel: NSObject {
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
    class func requestDiscussion(
        urlSuffix: String?,
        completionHandler: @escaping (LCXValueResponse<[DiscussionModel]>) -> Void
    ) {

    }
    
}
