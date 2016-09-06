//
//  SearchTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchTimelineViewController: TimelineViewController, getUsersHandler {

    var users: [User]?
    var me: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SearchTimelineViewController.dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let user = me {
            if let content = searchBar.text {
                if !content.isEmpty {
                    SocketIOManager.getAllNotices(user.id, count: 0, time: NSDate(), keyword: content, handler: self)
                    SocketIOManager.getUsers(content, handler: self)
                }
            }
        }
    }
    
    override func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        return
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
            let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! TimelineCell
            cell.user = me
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendTableViewCell
            if let users = users {
                let user = users[indexPath.row]
                cell.nameLabel.text = user.name
            }
            return cell
        }
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
}
