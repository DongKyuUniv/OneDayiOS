//
//  SearchTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol SearchTimelineViewInput {
    func search(user: User, content: String)
}

protocol SearchTimelineViewOutput {
    func setUsers(users: [User])
    func setNotices(notices: [Notice])
}

class SearchTimelineViewController: UITableViewController, getUsersHandler, UISearchBarDelegate, SearchTimelineViewOutput {

    var presenter: SearchTimelinePresenter!
    var users: [User]?
    var me: User?
    var notices: [Notice]?
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        searchBar.barStyle = .BlackTranslucent
        searchBar.tintColor = MAIN_RED
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.tintColor = MAIN_RED
        
        self.tableView.registerNib(UINib(nibName: "Timeline", bundle: nil), forCellReuseIdentifier: TimelineCell.CELL_ID)
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView()
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SearchTimelineViewController.dismissKeyboard)))
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let user = me {
            if let content = searchBar.text {
                if !content.isEmpty {
                    presenter.search(user, content: content)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "타임라인"
        } else {
            return "사용자"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let notices = notices {
                if let user = me {
                    let cell = TimelineCell.cell(tableView, cellForRowAtIndexPath: indexPath, notice: notices[indexPath.row], user: user)
                    cell.user = user
                    return cell
                }
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendTableViewCell
            if let users = users {
                let user = users[indexPath.row]
                cell.nameLabel.text = user.name
            }
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let notices = notices {
                return notices.count
            }
        } else {
            if let users = users {
                return users.count
            }
        }
        return 0
    }
    
    func onGetUserSuccess(users: [User]) {
        print("getUsers 성공")
        self.users = users
        self.tableView.reloadData()
    }
    
    func onGetUserException(code: Int) {
        print("getUsers 실패")
    }
    
    //  SearchTimelineViewOutput
    
    func setUsers(users: [User]) {
        self.users = users
        self.tableView.reloadData()
    }
    
    func setNotices(notices: [Notice]) {
        self.notices = notices
        self.tableView.reloadData()
    }
}
