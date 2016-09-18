//
//  TimelinePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelinePresenter: TimelineViewInput {
    
    var view: TimelineViewOutput!
    
    var interactor: TimelineInteractorInput!
    
    var wireframe: TimelineWireframe!
    
    // TimelineViewInput
    
    func searchBarClick(viewController: UITableViewController) {
        // 검색 바 클릭
        wireframe.searchTimelineWireframe.presentSearchTimelineViewController(viewController: viewController)
    }
    
    func addTimeline(viewController: UITableViewController, user: User) {
        wireframe.insertTimelineWireframe.presentInsertTimeline(viewController, user: user)
    }
}