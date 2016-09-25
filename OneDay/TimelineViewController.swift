//
//  TimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol TimelineViewInput {
    func searchBarClick(viewController: UITableViewController, user: User)
    func addTimeline(viewController: UITableViewController, user: User)
    func showComments(viewController: UIViewController, user: User, notice: Notice)
}

protocol TimelineViewOutput {
    
}

class TimelineViewController: UITableViewController, getAllNoticeHandler, OnCommentCellClickListener, UISearchBarDelegate, ImageTabDelegate, TimelineViewOutput {

    var user: User?
    var notices: [Notice]?
    var notice: Notice?
    var image: UIImage?
    var tabHeight: CGFloat?
    
    var presenter: TimelinePresenter!
    
    let searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "검색"
        searchBar.delegate = self
        searchBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationItem.titleView = searchBar
        
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = NAV_BAR_BLACK
        super.tabBarController?.selectedIndex = 0
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.registerNib(UINib(nibName: "Timeline", bundle: nil), forCellReuseIdentifier: TimelineCell.CELL_ID)
    }
    
    @IBAction func onClickInsertTimeline(sender: AnyObject) {
        if let user = user {
            presenter.addTimeline(self, user: user)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let curUser = user {
            SocketIOManager.getAllNotices(curUser.id, count: 0, time: NSDate(), handler: self)
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if let user = user {
            presenter.searchBarClick(self, user: user)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notices = self.notices {
            return notices.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let notices = self.notices {
            let notice = notices[indexPath.row]
            if let user = user {
                let cell = TimelineCell.cell(tableView, cellForRowAtIndexPath: indexPath, notice: notice, user: user)
                cell.handler = self
                return cell
            }
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func onGetAllNoticeSuccess(notices: [Notice]) {
        print("글 다 받아오기 성공")
        self.notices = notices
        tableView.reloadData()
    }
    
    
    func onGetAllNoticeException(code: Int) {
        print("글 다 받아오기 실패")
    }
    
    func onCommentClick(notice: Notice) {
//        self.notice = notice
        if let user = self.user {
            presenter.showComments(self, user: user, notice: notice)
        }
    }
    
    func onSettingClick(cell: TimelineCell, notice: Notice) {
//        self.notice = notice
        if let user = user {
            cell.presentSetting(viewController: self, notice: notice, user: user)
        }
    }
    
    func onRemoveNotice(notice: Notice) {
        self.notices?.removeAtIndex((self.notices?.indexOf({
            data in
            return true
        }))!)
        tableView.reloadData()
    }
    
    func imageTabbed(image: UIImage) {
        self.image = image
        self.performSegueWithIdentifier("ImageDetailSegue", sender: self)
    }
}
