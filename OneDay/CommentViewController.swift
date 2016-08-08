//
//  CommentViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 8..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CommentViewController: UITableViewController {
    
    var notice: Notice?
    var user: User?
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notice = self.notice {
            return notice.comments.count
        }
        return 0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
        if let notice = self.notice {
            let comment = notice.comments[indexPath.row]
            cell.nameLabel.text = comment.authorName
            cell.createdLabel.text = "\(comment.created)"
            cell.contentLabel.text = comment.content
        }
        return cell
    }
}
