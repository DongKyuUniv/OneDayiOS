//
//  MainViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UpdateUserDelegate {

    var user:User?
    @IBAction func insertNotice(sender: UIBarButtonItem) {
        performSegueWithIdentifier("insertTimeline", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vcs = viewControllers {
            let navigationVC = vcs[0] as! UINavigationController
            print("뷰컨트롤러 \(vcs)")
            let timelineVC = navigationVC.viewControllers[0] as! TimelineViewController
            
            let friendNavigationVC = vcs[1] as! UINavigationController
            let friendsVC = friendNavigationVC.viewControllers[0] as! FriendTableViewController
            
            let profileNavigationVC = vcs[2] as! UINavigationController
            let profileVC = profileNavigationVC.viewControllers[0] as! ProfileViewController
            
            timelineVC.user = user
            tabHeight = self.tabBar.frame.size.height
            friendsVC.user = user
            profileVC.user = user
            profileVC.userDelegate = self
        }
        
        tabBar.tintColor = MAIN_RED
        tabBar.barTintColor = LIGHT_BLACK
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUser(user: User) {
        self.user = user
        
        if let vcs = viewControllers {
            let navigationVC = vcs[0] as! UINavigationController
            let timelineVC = navigationVC.viewControllers[0] as! TimelineViewController
            let friendsVC = vcs[1] as! FriendTableViewController
            
            timelineVC.user = user
            friendsVC.user = user
        }
    }
}
