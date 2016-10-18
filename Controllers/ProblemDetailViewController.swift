//
//  ProblemDetailViewController.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/11/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit

class ProblemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Model
    var urlSuffix: String!
    var discussUrlSuffix: String!
    var problemModel: ProblemDetailModel?
    var discussionArray: [DiscussionModel]?

    fileprivate var _tableView :UITableView!
    fileprivate var tableView: UITableView {
        get{
            if(_tableView != nil){
                return _tableView!;
            }
            _tableView = UITableView();
            _tableView.separatorStyle = .none;
            _tableView.register(ProblemDetailTableViewCell.self, forCellReuseIdentifier: ProblemDetailTableViewCell.description())
            _tableView.register(DiscussionTableViewCell.self, forCellReuseIdentifier: DiscussionTableViewCell.description())
            _tableView.delegate = self
            _tableView.dataSource = self
            return _tableView!;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            (make) -> Void in
            make.top.bottom.left.right.equalTo(self.view)
        }
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.contentMode = .center
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        rightButton.setImage(UIImage(named: "ic_more_horiz_36pt")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: #selector(ProblemDetailViewController.rightClick), for: .touchUpInside)

        refreshAll()
    }
    @objc fileprivate func rightClick() {
        
    }
    fileprivate func refreshProblem() {
        ProblemDetailModel.requestDetail(urlName: urlSuffix) {
            (response: LCXValueResponse<ProblemDetailModel>) -> Void in
            if response.success {
                self.problemModel = response.value
                self.problemModel?.title = self.title
                self.tableView.reloadData()
            }
        }
    }
    fileprivate func refreshDiscussion() {
        DiscussionModel.requestDiscussion(urlSuffix: discussUrlSuffix) {
            (response: LCXValueResponse<[DiscussionModel]>) -> Void in
            if response.success {
                self.discussionArray = response.value
                self.tableView.reloadData()
            }
        }
    }
    func refreshAll() {
        refreshProblem()
        refreshDiscussion()
    }
    
    // MARK: - TableView Protocols
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch problemDetialSectionsEnum(rawValue: section)! {
        case .problem:
            return 3
        case .comments:
            return discussionArray?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO!!!
        let cell = UITableViewCell()
        return cell
    }
}

enum problemDetialSectionsEnum: Int {
    case problem = 0, comments
}
enum problemComponentsENum: Int {
    case content = 0, info, tags
}
