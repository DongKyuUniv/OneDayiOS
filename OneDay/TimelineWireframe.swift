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
    
    var searchTimelineWireframe: SearchTimelineWireframe!
    
    var insertTimelineWireframe: InsertTimelineWireframe!
    
    var presentViewController: UIViewController!
    
    func presentTimelineViewController(viewController: UITabBarController, user: User) {
        let newViewController = getTimelineViewController()
        newViewController.presenter = presenter
        presenter.view = newViewController
        newViewController.user = user
        
        viewController.viewControllers = [newViewController]
    }
    
    func presentSearchTimelineInterface(viewController: UITableViewController) {
        let searchTimelinePresenter = SearchTimelinePresenter()
        let searchTimelineInteractor = SearchTimelineInteractor()
        let searchTimelineWireframe = SearchTimelineWireframe()
        
        searchTimelineWireframe.presenter = searchTimelinePresenter
        searchTimelinePresenter.wireframe = searchTimelineWireframe
        searchTimelinePresenter.interactor = searchTimelineInteractor
        searchTimelineInteractor.presenter = searchTimelinePresenter
        
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
}
