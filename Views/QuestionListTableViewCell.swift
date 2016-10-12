//
//  QuestionListTableViewCell.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(question: QuestionListModel) {
        textLabel?.text = question.title
    }

}
