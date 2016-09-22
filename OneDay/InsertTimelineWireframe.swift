//
//  InsertTimelineWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class InsertTimelineWireframe {
    
    var presenter: InsertTimelinePresenter!
    
    func presentInsertTimeline(viewController: UIViewController, user: User) {
        let newViewController = getInsertTimelineViewController()
        newViewController.presenter = presenter
        presenter.view = newViewController
        newViewController.user = user
        viewController.navigationController?.pushViewController(newViewController, animated: true)
//        viewController.presentViewController(newViewController, animated: true, completion: nil)
    }
    
    func getInsertTimelineViewController() -> InsertTimelineViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("InsertTimelineViewController") as! InsertTimelineViewController
        return vc
    }
}
