//
//  ProblemDetailViewController.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/11/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

class ProblemDetailViewController: UIViewController {
    
    // MARK: - Model
    var urlSuffix: String!
    var discussUrlSuffix: String!
    var problemModel: ProblemDetailModel? {
        didSet {
            updateUI()
        }
    }
    var discussionArray: [DiscussionModel]?
    
    // MARK: - View
    var _textView: UITextView!
    var textView: UITextView {
        if (_textView != nil) {
            return _textView
        }
        _textView = UITextView()
        return _textView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            (make) -> Void in
            make.top.bottom.left.right.equalTo(self.view)
        }
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.contentMode = .center
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        rightButton.setImage(UIImage(named: "ic_more_horiz_36pt")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: #selector(ProblemDetailViewController.rightClick), for: .touchUpInside)

        refreshProblem()
    }
    @objc fileprivate func rightClick() {
        
    }
    fileprivate func refreshProblem() {
        ProblemDetailModel.requestDetail(urlName: urlSuffix) {
            (response: LCXValueResponse<ProblemDetailModel>) -> Void in
            if response.success {
                self.problemModel = response.value
                self.problemModel?.title = self.title
            }
        }
    }
    
    func updateUI() {
        textView.attributedText = problemModel?.HTMLcontent?.attributedStringFromHTML
    }
    
}
