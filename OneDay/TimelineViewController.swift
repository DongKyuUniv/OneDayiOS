//
//  TimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController, TimelineView, getAllNoticeHandler, OnCommentCellClickListener {

    var user: User?
    var notices: [Notice]?
    var handler: TimelineUserActionListener?
    var notice: Notice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handler = TimelinePresenter(view: self)
        if let curUser = user {
            SocketIOManager.getAllNotices(curUser.id, count: 0, time: NSDate(), handler: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notices = self.notices {
            print("notices count = \(notices.count)")
            return notices.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell", forIndexPath: indexPath) as! TimelineCell
        if let notices = self.notices {
            let notice = notices[indexPath.row]
            cell.notice = notice
            cell.handler = self
            cell.user = self.user
            cell.authorName.text = notice.authorName
            cell.content.text = notice.content
            cell.created.text = dateToString(notice.created)
            cell.likeCount.text = "\(notice.likes.count)"
            cell.badCount.text = "\(notice.bads.count)"
            cell.commentCount.text = "\(notice.comments.count)"
            print("like = \(notice.likes)")
        }
        return cell
    }
    
    func dateToString(date: NSDate) -> String {
        var sec = (Int(NSDate().timeIntervalSince1970) - Int(date.timeIntervalSince1970))
        var hour = 0
        var min = 0
        if sec < 86400 {
            hour = sec / 3600
            if hour > 0 {
                sec /= hour
            }
            min = sec / 60
            
            if hour == 0 && min == 0 {
                return "얼마 전"
            } else if hour == 0 {
                return "\(min)분 전"
            } else {
                return "\(hour)시간 전"
            }
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return dateFormatter.stringFromDate(date)
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
        print("글 개수 = \(notices.count)")
        self.tableView.reloadData()
    }
    
    
    func onGetAllNoticeException(code: Int) {
        print("글 다 받아오기 실패")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue id = \(segue.identifier)")
        if let id = segue.identifier {
            if id == "commentSegue" {
                let vc = segue.destinationViewController as! CommentViewController
                if let notices = self.notices {
                    vc.notice = notices[0]
                    vc.user = user
                }
            }
        }
    }
    
    func onCommentClick(notice: Notice) {
        print("commentClick")
        self.notice = notice
    }
}
