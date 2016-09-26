//
//  UpdateProfilePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class UpdateProfilePresenter: UpdateProfileViewInput, UpdateProfileInteractorOutput {
    
    var view: UpdateProfileViewOutput?
    
    var wireframe: UpdateProfileWireframe?
    
    var interactor: UpdateProfileIneteractor?
    
    // UpdateProfileViewInput
    
    func updateProfileSubmit(user: User, name: String?, email: String?, birth: NSDate) {
        if let name = name {
            if !name.isEmpty && name != user.name {
                interactor?.updateName(user, name: name)
            }
        }
        
        if let email = email {
            if !email.isEmpty && email != user.email {
                interactor?.updateEmail(user, email: email)
            }
        }
        
        if user.birth != birth {
            interactor?.updateBirth(user, birth: birth)
        }
        
//        if count == 0 {
//            dismissViewControllerAnimated(true, completion: nil)
//        }
    }
    
    // UpdateProfileInteractorOutput
    
    func updateProfileSuccess() {
        view?.updateProfileSuccess()
    }
    
    
    func updateProfileException(err: UpdateProfileError) {
        view?.updateProfileException(err)
    }
}
