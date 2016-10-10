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
    var tab: String?
    var page = 0
    var questionList: [QuestionModel]?

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
    }
    
    func setupNavigationItem() {
        // TODO
    }
    
    func refresh() {
        // TODO
    }
    
    // MARK - UITableView Protocals
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListTableViewCell.description(), for: indexPath)
        // TODO: data binding
        return cell
    }

}
