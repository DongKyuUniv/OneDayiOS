//
//  FriendPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

class FriendPresenter: FriendTableViewInput, FriendInteractorOutput {
    
    var view: FriendTableViewOutput?
    
    var wireframe: FriendWireframe?
    
    var interactor: FriendInteractor?
    
    
    // FriendTableViewInput
    
    func getFriendsPhone(friends: [String]) {
        interactor?.getContact(friends)
    }
    
    
    // FriendInteractorOutput
    
    func setContact(phoneNums: [String]) {
        view?.setFriendsPhone(phoneNums)
    }
}
