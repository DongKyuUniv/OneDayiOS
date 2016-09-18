//
//  SearchTimelineWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchTimelineWireframe {
    
    var presenter: SearchTimelinePresenter!
    
    func presentSearchTimelineViewController(viewController vc: UITableViewController) {
        let newViewController = getSearchTimelineViewController()
        newViewController.presenter = presenter
        
    }
    
    func getSearchTimelineViewController() -> SearchTimelineViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("SearchTimelineViewController") as! SearchTimelineViewController
        return vc
    }
}
