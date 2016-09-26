//
//  FriendWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FriendWireframe {
    
    var presenter: FriendPresenter?
    
    func presentFriendViewController(viewController: UITabBarController, user: User) {
        let newViewController = getFriendViewController()
        newViewController.user = user
        newViewController.presenter = presenter
        newViewController.tabBarItem = UITabBarItem(title: "친구", image: UIImage(named: "ic_people_white"), tag: 2)
        
        viewController.viewControllers?.append(newViewController)
    }
    
    
    func getFriendViewController() -> FriendTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("FriendTableViewController") as! FriendTableViewController
        return viewController
    }
}
