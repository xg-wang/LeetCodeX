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

//let problemDetailPattern = "^/category/(\\d+)/(\\S+)"

class ProblemDetailModel: NSObject {
    var title: String?
    var HTMLcontent: String?
    
    init(rootNode: JiNode) {
        super.init()
        HTMLcontent = rootNode.xPath("./div[@class='question-content']").first?.rawContent
        // TODO: difficulty, total submit/pass
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
