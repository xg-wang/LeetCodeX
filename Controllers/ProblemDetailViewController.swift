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
        _textView.isEditable = false
        return _textView
    }
    let footerLabel = UIView()
    let acceptLabel = UILabel()
    let submitLabel = UILabel()
    let difficultyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

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
    
    func setupViews() {
        view.addSubview(footerLabel)
        footerLabel.snp.makeConstraints {
            (make) -> Void in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.height.equalTo(40)
        }
        view.addSubview(textView)
        textView.snp.makeConstraints {
            (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.footerLabel)
        }
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.contentMode = .center
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        rightButton.setImage(UIImage(named: "ic_more_horiz_36pt")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: #selector(ProblemDetailViewController.rightClick), for: .touchUpInside)
        print(rightButton.bounds)
        print(rightButton.frame)
    }
    
    func updateUI() {
        textView.attributedText = problemModel?.HTMLcontent?.attributedStringFromHTML
    }
    
}
