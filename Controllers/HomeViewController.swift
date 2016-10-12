//
//  HomeViewController.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var category: String?
    var page = 0
    var questionList: [QuestionListModel]?

    private var _tableview: UITableView!
    private var tableview: UITableView {
        if (_tableview != nil) {
            return _tableview
        }
        _tableview = UITableView()
        _tableview.separatorStyle = .none
        _tableview.register(QuestionListTableViewCell.self,
                            forCellReuseIdentifier: QuestionListTableViewCell.description())
        _tableview.delegate = self
        _tableview.dataSource = self
        return _tableview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "LeetCodeX"
        setupNavigationItem()
        view.addSubview(tableview)
        tableview.snp.makeConstraints {
            (make) -> Void in
            make.top.bottom.left.right.equalTo(self.view)
        }
        tableview.mj_header = LCXRefreshHeader(refreshingBlock: {
            [weak self] () -> Void in
            self?.refresh()
        })
        refreshLists()
    }
    
    func setupNavigationItem() {
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftButton.contentMode = .center
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        leftButton.setImage(UIImage(named: "ic_menu_36pt")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), for: .touchUpInside)
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.contentMode = .center
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        rightButton.setImage(UIImage(named: "ic_more_horiz_36pt")?.withRenderingMode(.alwaysTemplate), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: #selector(HomeViewController.rightClick), for: .touchUpInside)
    }
    
    @objc fileprivate func leftClick() {
        LCXClient.sharedInstance.drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    @objc fileprivate func rightClick() {
        LCXClient.sharedInstance.drawerController?.toggleRightDrawerSide(animated: true, completion: nil)
    }
    
    func refresh() {
        if category == nil {
            category = "oj"
        }
        QuestionListModel.requestList(category: category!) {
            (response: LCXValueResponse<[QuestionListModel]>) -> Void in
            if response.success {
                self.questionList = response.value
                self.tableview.reloadData()
                self.page = 0
            }
            self.tableview.mj_header.endRefreshing()
        }
    }
    func refreshLists() {
        tableview.mj_header.beginRefreshing()
    }
    
    // MARK - UITableView Protocals
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let questions = questionList {
            return questions.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListTableViewCell.description(), for: indexPath) as! QuestionListTableViewCell
        cell.bind(question: questionList![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = questionList?[indexPath.row]
        if let qurl = question?.href, let qtitle = question?.title {
            let questionVC = QuestionDetailViewController()
            questionVC.urlSuffix = qurl
            questionVC.title = qtitle
            navigationController?.pushViewController(questionVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
