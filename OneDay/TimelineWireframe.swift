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
    
    var commentWireframe: CommentWireframe!
    
    func presentTimelineViewController(viewController: UITabBarController, user: User) {
        let navigationController = getTimelineNavigationController()
        let newViewController = getTimelineViewController()
        newViewController.presenter = presenter
        presenter.view = newViewController
        newViewController.user = user
        newViewController.tabBarItem = UITabBarItem(title: "타임라인", image: UIImage(named: "ic_public_white"), tag: 1)
        
        navigationController.viewControllers = [newViewController]
        viewController.viewControllers = [navigationController]
    }
    
    func presentSearchTimelineInterface(viewController: UITableViewController, user: User) {
        searchTimelineWireframe.presentSearchTimelineViewController(viewController: viewController, user: user)
    }
    
    func presentInsertTimelineInterface(viewController: UITableViewController, user: User) {
        insertTimelineWireframe.presentInsertTimeline(viewController, user: user)
    }
    
    func presentCommentInterface(viewController: UIViewController, user: User, notice: Notice) {
        commentWireframe.presentCommentViewController(viewController, user: user, notice: notice)
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
