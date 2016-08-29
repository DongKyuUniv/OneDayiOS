//
//  TimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController, getAllNoticeHandler, OnCommentCellClickListener, removeNoticeHandler, UISearchBarDelegate, ImageTabDelegate {

    var user: User?
    var notices: [Notice]?
    var notice: Notice?
    var image: UIImage?
    var tabHeight: CGFloat?
    
    let searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "검색"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let curUser = user {
            SocketIOManager.getAllNotices(curUser.id, count: 0, time: NSDate(), handler: self)
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.performSegueWithIdentifier("SearchTimelineSegue", sender: self)
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
            cell.imageTabHandler = self
            if let image = notice.authorProfileImage {
                cell.profileImage.kf_setImageWithURL(NSURL(string: "\(imageURL)\(image)"))
            }
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
            } else if id == "SearchTimelineSegue" {
                let vc = segue.destinationViewController as! SearchTimelineViewController
                vc.me = user
                vc.notice = notice
            } else if id == "ImageDetailSegue" {
                let vc = segue.destinationViewController as! ImageDetailViewController
                if let image = image {
                    vc.image = image
                }
            }
        }
    }
    
    func onCommentClick(notice: Notice) {
        self.notice = notice
    }
    
    func onSettingClick(notice: Notice) {
        self.notice = notice
        let alert = UIAlertController(title: "설정", message: nil, preferredStyle: .Alert)
        if let user = user {
            if notice.author == user.id {
                alert.addAction(UIAlertAction(title: "삭제", style: .Default, handler: {
                    action in
                    SocketIOManager.removeNotice(notice, handler: self)
                }))
                alert.addAction(UIAlertAction(title: "수정", style: .Default, handler: {
                    action in
                    // 수정
                    self.performSegueWithIdentifier("updateTimeline", sender: self)
                }))
            }
        }
        alert.addAction(UIAlertAction(title: "취소", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func onRemoveNoticeException(code: Int) {
        print("게시글 삭제 에러")
    }
    
    func onRemoveNoticeSuccess(notice: Notice) {
        print("게시글 삭제 성공")
        self.notices?.removeAtIndex((self.notices?.indexOf({
            data in
            print("data.content = \(data.content)")
            return true
        }))!)
        tableView.reloadData()
    }
    
    func imageTabbed(image: UIImage) {
        self.image = image
        self.performSegueWithIdentifier("ImageDetailSegue", sender: self)
    }
}
