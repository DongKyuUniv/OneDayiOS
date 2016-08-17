//
//  FriendTableViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController, getFriendProfileHandler {
    
    var user: User?
    var friends: [User]?
    
    override func viewDidAppear(animated: Bool) {
        if let user = user {
            SocketIOManager.getFriendProfile(user.friends, handler: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friends = friends {
            return friends.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
        if let friends = friends {
            let friend = friends[indexPath.row]
            cell.nameLabel.text = friend.name
            loadImage(cell.imageView!, url: friend.profileImageUri)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Friend"
    }
    
    func loadImage(imageView: UIImageView, url: String) {
        let url = NSURL(string: url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (responseData, responseUrl, error) -> Void in
            if let data = responseData {
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    imageView.image = UIImage(data: data)
                })
            }
        }
        task.resume()
    }
    
    func onGetFriendProfileSuccess(user: [User]) {
        self.friends = user
    }
    
    func onGetFriendProfileException(code: Int) {
        print("getProfile 실패")
    }
}
