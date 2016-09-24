//
//  TimelinePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelinePresenter: TimelineViewInput, TimelineInteractorOutput {
    
    var view: TimelineViewOutput!
    
    var interactor: TimelineInteractor!
    
    var wireframe: TimelineWireframe!
    
    // TimelineViewInput
    
    func searchBarClick(viewController: UITableViewController) {
        // 검색 바 클릭
        wireframe.presentSearchTimelineInterface(viewController)
    }
    
    func addTimeline(viewController: UITableViewController, user: User) {
        wireframe.presentInsertTimelineInterface(viewController, user: user)
    }
    
    func showComments(viewController: UIViewController, user: User, notice: Notice) {
        wireframe.presentCommentInterface(viewController, user: user, notice: notice)
    }
}
