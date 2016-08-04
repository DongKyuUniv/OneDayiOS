//
//  TimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController, TimelineView, getAllNoticeHandler, loginHandler {

    var user: User?
    var notices: [Notice]?
    var handler: TimelineUserActionListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handler = TimelinePresenter(view: self)
        if let curUser = user {
            if curUser.name != nil {
                SocketIOManager.getAllNotices(curUser.id, count: 0, time: NSDate(), handler: self)
            } else {
                SocketIOManager.login(curUser.id, pw: curUser.password, context: self)
            }
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
        cell.authorName.text = "lee"
        return cell
    }
    
    func onGetAllNoticeSuccess(notices: [Notice]) {
        print("글 다 받아오기 성공")
        self.notices = notices
        self.refreshControl?.refreshing
    }
    
    func onGetAllNoticeException(code: Int) {
        print("글 다 받아오기 실패")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("segue = \(segue.identifier)")
    }
    
    func onLoginSuccess(user: User) {
        print("로그인 성공 = \(user)")
        self.user = user
        SocketIOManager.getAllNotices(user.id, count: 0, time: NSDate(), handler: self)
    }
    
    func onLoginException(code: Int) {
        showAlert("로그인 실패", message: "로그인에 실패하였습니다. \n비밀번호가 변경되었는지 확인하십시오.")
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: {
            action in
            exit(0)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
