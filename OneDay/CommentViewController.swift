//
//  CommentViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 8..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

enum InsertCommentError {
    case EMPTY_COMMENT
    case FAIL_TO_SERVER
}

protocol CommentViewInput {
    func insertComment(user: User, notice: Notice, comment: String?)
}

protocol CommentViewOutput {
    func insertCommentError(err: InsertCommentError)
    func insertCommentSuccess(comment: Comment)
}

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CommentViewOutput {
    
    var presenter: CommentPresenter!
    
    var notice: Notice?
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func onSubmit(sender: UIButton) {
        if let user = self.user {
            if let notice = self.notice {
                presenter.insertComment(user, notice: notice, comment: commentTextField.text)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = ULTRA_LIGHT_BLACK
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CommentViewController.dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var commentTextFieldMarginBottom: NSLayoutConstraint!
    
    @IBOutlet weak var submitMarginBottom: NSLayoutConstraint!
    
    @IBOutlet weak var submit: UIButton!
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.CGRectValue() {
                print("tabHeight = \(tabHeight)")
                if let tabHeight = self.tabBarController?.tabBar.frame.size.height {
                    commentTextFieldMarginBottom.constant += keyboardSize.height - tabHeight
                    submitMarginBottom.constant += keyboardSize.height - tabHeight
                    submit.frame.origin.y -= keyboardSize.height - tabHeight
                    commentTextField.frame.origin.y -= keyboardSize.height - tabHeight
                }
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.CGRectValue() {
                if let tabHeight = self.tabBarController?.tabBar.frame.size.height {
                    commentTextFieldMarginBottom.constant -= keyboardSize.height - tabHeight
                    submitMarginBottom.constant -= keyboardSize.height - tabHeight
                    submit.frame.origin.y += keyboardSize.height - tabHeight
                    commentTextField.frame.origin.y += keyboardSize.height - tabHeight
                }
            }
        }
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
    
    // InsertCommentOutput
    
    func insertCommentError(err: InsertCommentError) {
        var alert: UIAlertController!
        
        switch err {
        case .EMPTY_COMMENT:
            alert = UIAlertController(title: "에러", message: "댓글을 입력해주세요", preferredStyle: .Alert)
            
        case .FAIL_TO_SERVER:
            alert = UIAlertController(title: "에러", message: "서버등록에 실패했습니다", preferredStyle: .Alert)
        default:
            print("dd")
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func insertCommentSuccess(comment: Comment) {
        if let notice = notice {
            notice.comments.append(comment)
        }
    }
}
