//
//  UpdateProfileInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol UpdateProfileInteractorInput {
    func updateName(user: User, name: String)
    func updateEmail(user: User, email: String)
    func updateBirth(user: User, birth: NSDate)
}

protocol UpdateProfileInteractorOutput {
    func updateProfileSuccess()
    func updateProfileException(err: UpdateProfileError)
}

class UpdateProfileIneteractor: UpdateProfileInteractorInput, setNameHandler, setMailHandler, setBirthHandler {
    
    var count = 0
    var presenter: UpdateProfilePresenter!
    
    // UpdateProfileInteractorInput
    
    func updateName(user: User, name: String) {
        SocketIOManager.setName(user.id, name: name, handler: self)
        user.name = name
        count += 1
    }
    
    func updateBirth(user: User, birth: NSDate) {
        SocketIOManager.setBirth(user.id, birth: birth, handler: self)
        user.birth = birth
        count += 1
    }
    
    func updateEmail(user: User, email: String) {
        SocketIOManager.setMail(user.id, mail: email, handler: self)
        user.email = email
        count += 1
    }
    
    
    func onSetMailSuccess() {
        count -= 1
        if count == 0 {
            presenter.updateProfileSuccess()
        }
    }
    
    func onSetNameSuccess() {
        count -= 1
        if count == 0 {
            presenter.updateProfileSuccess()
        }
    }
    
    func onSetMailException() {
        presenter.updateProfileException(UpdateProfileError.EMAIL)
    }
    
    func onSetNameException() {
        presenter.updateProfileException(UpdateProfileError.NAME)
    }
    
    func onSetBirthSuccess() {
        count -= 1
        if count == 0 {
            presenter.updateProfileSuccess()
        }
    }
    
    func onSetBirthException() {
        presenter.updateProfileException(UpdateProfileError.EMAIL)
    }
}
