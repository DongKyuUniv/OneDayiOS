//
//  CommentViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 8..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, commentHandler {
    
    var notice: Notice?
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func onSubmit(sender: UIButton) {
        if let user = self.user {
            if let notice = self.notice {
                if let comment = commentTextField.text {
                    if !comment.isEmpty {
                        SocketIOManager.comment(user.id, noticeId: notice.id, comment: comment, name: user.name, handler: self)
                        notice.comments.append(Comment(id: user.id, notice_id: notice.id, authorId: user.id, authorProfileImage: user.profileImageUri, authorName: user.name, content: comment, created: NSDate()))
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
        
        if let notice = self.notice {
            let comment = notice.comments[indexPath.row]
            cell.nameLabel.text = comment.authorName
            cell.createdLabel.text = "\(comment.created)"
            cell.contentLabel.text = comment.content
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notice = self.notice {
            return notice.comments.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func onCommentSucces() {
        print("댓글 달기 성공")
    }
    
    
    func onCommentException(code: Int) {
        print("댓글 달기 실패")
    }
}
