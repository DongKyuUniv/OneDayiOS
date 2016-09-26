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
        
        self.tabBarController?.selectedIndex = 0
        self.selectedIndex = 0
        
        let mainDependencies = MainDependencies()
        if let user = user {
            mainDependencies.setEnvironment(self, user: user)
        }
        
        tabHeight = self.tabBar.frame.size.height
        
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
