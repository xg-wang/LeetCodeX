//
//  LCXSettings.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation

let keyPrefix = "me.xgwang.LCXSettings."

class LCXSettings: NSObject {
    static let sharedInstance = LCXSettings()
    
    subscript(key: String) -> String? {
        get {
            return UserDefaults.standard.object(forKey: keyPrefix+key) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyPrefix+key)
        }
    }
}
