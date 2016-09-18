//
//  MainDependencies.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainDependencies {
    
    func setEnvironment(viewController: UITabBarController, user: User) {
        
        let timelinePresenter = TimelinePresenter()
        let timelineWireframe = TimelineWireframe()
        let timelineInteractor = TimelineInteractor()
        
        timelineWireframe.presenter = timelinePresenter
        timelineInteractor.presenter = timelinePresenter
        timelinePresenter.wireframe = timelineWireframe
        timelinePresenter.interactor = timelineInteractor
        
        timelineWireframe.presentTimelineViewController(viewController, user: user)
        
        let friendPresenter = FriendPresenter()
        let friendInteractror = FriendInteractor()
        let friendWireframe = FriendWireframe()
        
        friendWireframe.presenter = friendPresenter
        friendPresenter.interactor = friendInteractror
        friendInteractror.presenter = friendPresenter
        
        friendWireframe.presentFriendViewController(viewController, user: user)
        
        let profilePresenter = ProfilePresenter()
        let profileInteractor = ProfileInteractor()
        let profileWireframe = ProfileWireframe()
        
        profilePresenter.interactor = profileInteractor
        profilePresenter.wireframe = profileWireframe
        profileInteractor.presenter = profilePresenter
        profileWireframe.presenter = profilePresenter
        
        profileWireframe.presentProfileViewController(viewController, user: user)
        
        
        
        let insertTimelinePresenter = InsertTimelinePresenter()
        let insertTimelineInteractor = insertTimelineIn
    }
    
    func getNotificationViewController() -> NotificationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("NotificationViewController") as! NotificationViewController
        return viewController
    }
}
