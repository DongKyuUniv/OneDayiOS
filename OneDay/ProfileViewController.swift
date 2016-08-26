//
//  ProfileViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ProfileViewController: TimelineViewController, getProfileHandler, UpdateUserDelegate {
    
    var userDelegate: UpdateUserDelegate?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let notices = notices {
                return notices.count
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileViewCell
            if let user = user {
                cell.nameLabel.text = user.name
                cell.emailLabel.text = user.email
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                
                cell.birthLabel.text = dateFormatter.stringFromDate(user.birth)
            }
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = user {
            SocketIOManager.getProfile(user.id, handler: self)
        }
    }
    
    func onGetProfileSuccess(notices: [Notice]) {
        self.notices = notices
        tableView.reloadData()
    }
    
    func onGetProfileException(code: Int) {
        print("getProfile 실패")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let id = segue.identifier {
            if id == "updateProfileSegue" {
                print("data 전송 성공")
                let vc = segue.destinationViewController as! UpdateProfileViewController
                vc.user = user
                vc.userDelegate = self
            }
        }
    }
    
    func updateUser(user: User) {
        self.user = user
        if let delegate = userDelegate {
            delegate.updateUser(user)
        }
    }
}
