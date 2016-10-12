//
//  LCXResponse.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/10/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation

class LCXResponse: NSObject {
    var success: Bool   = false
    var message: String = "No message"
    init(success: Bool, message: String?) {
        super.init()
        self.success   = success
        if let message = message {
            self.message = message
        }
    }
    init(success: Bool) {
        super.init()
        self.success = success
    }
}

class LCXValueResponse<T>: LCXResponse {
    var value: T?
    
    override init(success: Bool) {
        super.init(success: success)
    }
    
    override init(success: Bool, message: String?) {
        super.init(success: success)
        if let message = message {
            self.message = message
        }
    }
    
    convenience init(value: T, success: Bool) {
        self.init(success: success)
        self.value = value
    }
    
    convenience init(value: T,success: Bool, message: String?) {
        self.init(value: value, success: success)
        if let message = message {
            self.message = message
        }
    }
}
