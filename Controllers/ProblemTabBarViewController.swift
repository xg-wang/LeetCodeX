//
//  ProblemTabBarViewController.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/18/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

class ProblemTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Model
    var urlSuffix: String!
    var discussUrlSuffix: String!
    var problemModel: ProblemDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let detailVC = ProblemDetailViewController()
        detailVC.urlSuffix = urlSuffix
        let discussVC = DiscussionViewController()
        discussVC.discussUrlSuffix = discussUrlSuffix
        viewControllers = [detailVC, discussVC]
    }

}
