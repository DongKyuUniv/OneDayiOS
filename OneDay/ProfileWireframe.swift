//
//  ProfileWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ProfileWireframe {
    
    var presenter: ProfilePresenter?
    
    func presentProfileViewController(viewController: UITabBarController, user: User) {
        let newViewController = getProfileViewContrller()
        newViewController.presenter = presenter
        newViewController.user = user
        presenter?.view = newViewController
        newViewController.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "ic_person_outline_white"), tag: 3)
        viewController.viewControllers?.append(newViewController)
    }
    
    func getProfileViewContrller() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        return viewController
    }
}

