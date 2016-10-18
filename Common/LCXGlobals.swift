//
//  LCXGlobals.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/11/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import Foundation

let LeetCodeDiscussURL = "https://discuss.leetcode.com/"
let LeetCodeProblemsURL = "https://leetcode.com/problems/"

func getGroups(in str: String, with pattern: String) -> [String] {
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    
    let matchGroup = regex?.firstMatch(in: str, options: [], range: NSMakeRange(0, str.characters.count))
    
    var groupMatches = [String]()
    
    if let groups = matchGroup {
        for group in 0..<groups.numberOfRanges {
            groupMatches.append((str as NSString).substring(with: groups.rangeAt(group)))
        }
    }
    return groupMatches
}
