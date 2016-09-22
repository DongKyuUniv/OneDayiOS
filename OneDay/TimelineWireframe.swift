//
//  TimelineWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineWireframe {
    var presenter: TimelinePresenter!
    
    var presentViewController: UIViewController!
    
    var insertTimelineWireframe: InsertTimelineWireframe!
    
    var searchTimelineWireframe: SearchTimelineWireframe!
    
    func presentTimelineViewController(viewController: UITabBarController, user: User) {
        let navigationController = getTimelineNavigationController()
        let newViewController = getTimelineViewController()
        newViewController.presenter = presenter
        presenter.view = newViewController
        newViewController.user = user
        
        navigationController.viewControllers = [newViewController]
        viewController.viewControllers = [navigationController]
    }
    
    func presentSearchTimelineInterface(viewController: UITableViewController) {
        searchTimelineWireframe.presentSearchTimelineViewController(viewController: viewController)
    }
    
    func presentInsertTimelineInterface(viewController: UITableViewController, user: User) {
        insertTimelineWireframe.presentInsertTimeline(viewController, user: user)
    }
    
    func getTimelineViewController() -> TimelineViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("TimelineViewController") as! TimelineViewController
        
        return vc
    }
    
    func getTimelineNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        return vc
    }
}
