//
//  SearchTimelineInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol SearchTimelineInteractorInput {
    func search(user: User, content: String)
}

protocol SearchTimelineInteractorOutput {
    func setUsers(users: [User])
    func setNotices(notices: [Notice])
}

class SearchTimelineInteractor: SearchTimelineInteractorInput, getAllNoticeHandler, getUsersHandler {
    
    var presenter: SearchTimelinePresenter!
    
    
    
    // SearchTimelineInteractorInput
    
    func search(user: User, content: String) {
        print("search       ")
        SocketIOManager.getAllNotices(user.id, count: 0, time: NSDate(), keyword: content, handler: self)
        SocketIOManager.getUsers(content, handler: self)
    }
    
    func onGetUserSuccess(users: [User]) {
        presenter.setUsers(users)
    }
    
    func onGetAllNoticeSuccess(notices: [Notice]) {
        presenter.setNotices(notices)
    }
    
    func onGetUserException(code: Int) {
        print("유저 정보 받아오기 실패")
    }
    
    func onGetAllNoticeException(code: Int) {
        print("노티스 전부 받아오기 실패")
    }
}
