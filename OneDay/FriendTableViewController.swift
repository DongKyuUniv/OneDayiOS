//
//  FriendTableViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import Contacts

class FriendTableViewController: UITableViewController, getFriendProfileHandler, recommendFriendByPhoneNumberHandler {
    
    var user: User?
    var friends: [User]?
    var recommendFriends: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = user {
            SocketIOManager.getFriendProfile(user.friends, handler: self)
            
            // 연락처 동기화
            var friends = [String]()
            let store = CNContactStore()
            let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey])
            do {
                try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: {contact, stop in
                    if let phoneNumContact = contact.phoneNumbers.first {
                        let number = phoneNumContact.value as! CNPhoneNumber
                        if let phoneNumber = number.valueForKey("digits") {
                            print(phoneNumber)
                            friends.append(phoneNumber as! String)
                        }
                    }
                })
            } catch let err {
                print(err)
                let alert = UIAlertController(title: "에러", message: "에러", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "주소록 접근 실패", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
            SocketIOManager.recommendFriendByPhoneNumber(user.id, friendPhoneNumbers: friends, handler: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 친구 추천
            if let friends = recommendFriends {
                return friends.count
            }
        } else if section == 1 {
            // 친구 목록
            if let friends = friends {
                return friends.count
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
        if indexPath.section == 0 {
            // 친구 추천
            if let friends = recommendFriends {
                let friend = friends[indexPath.row]
                cell.nameLabel.text = friend.name
                loadImage(cell.imageView!, url: friend.profileImageUri)
            }
        } else if indexPath.section == 1 {
            // 친구 목록
            if let friends = friends {
                let friend = friends[indexPath.row]
                cell.nameLabel.text = friend.name
                loadImage(cell.imageView!, url: friend.profileImageUri)
            }
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
        tableView.reloadData()
    }
    
    func onGetFriendProfileException(code: Int) {
        print("getProfile 실패")
    }
    
    func onRecommendFriendByPhoneNumberSuccess(user: [User]) {
        self.recommendFriends = user
        tableView.reloadData()
    }
    
    func onRecommendFriendByPhoneNumberException() {
        print("친구 추천 실패")
    }
}
