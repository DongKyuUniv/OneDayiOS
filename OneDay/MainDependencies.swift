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
        let insertTimelineInteractor = InsertTimelineInteractor()
        let insertTimelineWireframe = InsertTimelineWireframe()
        
        insertTimelinePresenter.interactor = insertTimelineInteractor
        insertTimelinePresenter.wireframe = insertTimelineWireframe
        insertTimelineInteractor.presenter = insertTimelinePresenter
        insertTimelineWireframe.presenter = insertTimelinePresenter
        
        let searchTimelinePresenter = SearchTimelinePresenter()
        let searchTimelineInteractor = SearchTimelineInteractor()
        let searchTimelineWireframe = SearchTimelineWireframe()
        
        searchTimelineWireframe.presenter = searchTimelinePresenter
        searchTimelinePresenter.wireframe = searchTimelineWireframe
        searchTimelinePresenter.interactor = searchTimelineInteractor
        searchTimelineInteractor.presenter = searchTimelinePresenter
        
        
        let commentPresenter = CommentPresenter()
        let commentWireframe = CommentWireframe()
        let commentInteractor = CommentInteractor()
        
        commentPresenter.interactor = commentInteractor
        commentPresenter.wireframe = commentWireframe
        commentWireframe.presenter = commentPresenter
        commentInteractor.presenter = commentPresenter
        
        timelineWireframe.searchTimelineWireframe = searchTimelineWireframe
        timelineWireframe.insertTimelineWireframe = insertTimelineWireframe
        timelineWireframe.commentWireframe = commentWireframe
    }
}
