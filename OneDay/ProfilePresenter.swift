//
//  ProfilePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ProfilePresenter: ProfileViewInput, ProfileInteractorOutput {
    
    var view: ProfileViewOutput?
    
    var interactor: ProfileInteractor?
    
    var wireframe: ProfileWireframe?
    
    // ProfileViewInput
    
    func imagePickerController(localPath: String, user: User) {
        interactor?.imagePickerController(localPath, user: user)
    }
    
    func getProfile(user: User) {
        interactor?.getProfile(user)
    }
    
    
    // ProfileInteractorOutput
    
    func getProfile(notices: [Notice]) {
        view?.getProfile(notices)
    }
    
    func setProfileImage(filename: String) {
        view?.setProfileImage(filename)
    }
}