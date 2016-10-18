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
    var problemgId: String?
    var urlName: String?
    var backgroundColorHex: String?
    
    init(rootNode: JiNode) {
        super.init()
    }
    
    // MARK - Model Related Request
    class func requestDiscussion(
        urlSuffix: String,
        completionHandler: @escaping (LCXValueResponse<[DiscussionModel]>) -> Void
    ) {

    }
    
}
