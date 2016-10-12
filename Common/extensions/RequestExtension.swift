//
//  RequestExtension.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/11/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation
import Alamofire
import Ji

enum DataRequestError: Error {
    case network(error: Error)
    case dataSerialization(error: Error)
    case htmlSerialization(reason: String)
}

extension DataRequest {
    static func JIHTMLResponseSerializer() -> DataResponseSerializer<Ji> {
        return DataResponseSerializer { request, response, data, error in
            guard error == nil else { return .failure(DataRequestError.network(error: error!)) }
            
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            
            guard case let .success(validData) = result else {
                return .failure(DataRequestError.dataSerialization(error: result.error! as! AFError))
            }
            
            if let jiHtml = Ji(htmlData: validData){
                return .success(jiHtml)
            }
            
            let failureReason = "HTML could not be serialized."
            return .failure(DataRequestError.htmlSerialization(reason: failureReason))
        }
    }
    
    @discardableResult
    func responseJiHtml(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<Ji>) -> Void)
        -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.JIHTMLResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}
