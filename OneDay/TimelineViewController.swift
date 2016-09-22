//
//  TimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol TimelineViewInput {
    func searchBarClick(viewController: UITableViewController)
    func addTimeline(viewController: UITableViewController, user: User)
    func showComments(notice: Notice)
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
        
        view.backgroundColor = BLACK
        
        tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = NAV_BAR_BLACK
        self.tabBarItem = UITabBarItem(title: "타임라인", image: UIImage(named: "ic_face_white"), tag: 1)
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
            presenter.searchBarClick(self)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue id = \(segue.identifier)")
        if let id = segue.identifier {
            if id == "CommentSegue" {
                let vc = segue.destinationViewController as! CommentViewController
                vc.notice = notice
                vc.user = user
            } else if id == "insertTimeline" {
                let vc = segue.destinationViewController as! InsertTimelineViewController
                vc.user = user
            } else if id == "updateTimeline" {
                let vc = segue.destinationViewController as! InsertTimelineViewController
                vc.user = user
                vc.notice = notice
            } else if id == "ImageDetailSegue" {
                let vc = segue.destinationViewController as! ImageDetailViewController
                vc.image = self.image
            }
        }
    }
    
    func onCommentClick(notice: Notice) {
//        self.notice = notice
        presenter.showComments(notice)
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
