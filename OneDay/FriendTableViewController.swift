//
//  FriendTableViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {

    var friends: [String:String] = ["이동규":"http://mimgnews2.naver.net/image/030/2016/07/06/article_06104845857903_99_20160706110317.png?type=w540", "김동희":"http://mimgnews2.naver.net/image/030/2016/07/06/article_06104845857903_99_20160706110317.png?type=w540"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
        let friendNames = Array(friends.keys)
        let friendImages = Array(friends.values)
        let friendName = friendNames[indexPath.row]
        let friendImage = friendImages[indexPath.row]
        cell.nameLabel.text = friendName
        loadImage(cell.imageView!, url: friendImage)
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
}
