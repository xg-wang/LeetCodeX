//
//  StringExtention.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/18/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

extension String {
    
    var attributedStringFromHTML: NSAttributedString? {
        guard let data = data(using: .unicode, allowLossyConversion: true) else {
            return nil
        }
        return try? NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            
    }
    var rawStringFromHTML: String {
        return attributedStringFromHTML?.string ?? ""
    }
}
