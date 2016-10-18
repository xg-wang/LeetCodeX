//
//  ProblemListTableViewCell.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

class ProblemListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(problem: ProblemListModel) {
        textLabel?.text = problem.title
    }

}
