//
//  FindIdViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

class FindPasswordPresenter: FindPasswordViewInput, FindPasswordInteractorOutput {
    
    var view: FindPasswordViewOutput!
    
    var interactor: FindPasswordInteractor!
    
    var wireframe: FindPasswordWireframe!
    
    // FindPasswordViewInput
    
    func findPassword(id: String?, email: String?) -> Bool {
        if let email = email {
            if email.isEmpty {
                view.showError(FindPasswordError.MAIL_EMPTY)
                return false
            }
            
            if !email.containsString("@") {
                view.showError(FindPasswordError.INVALID_MAIL)
                return false
            }
            
            if let id = id {
                if id.isEmpty {
                    view.showError(FindPasswordError.ID_EMPTY)
                    return false
                }
                
                interactor.findPassword(id, mail: email)
                return true
            } else {
                view.showError(FindPasswordError.ID_EMPTY)
                return false
            }
        }
        
        view.showError(FindPasswordError.MAIL_EMPTY)
        return false
    }
    
    // FindPasswordInteractorOutput
    
    func findPasswordSuccess(password: String) {
        view.showPassword(password)
    }
    
    func findPasswordFailed(code: Int) {
        if code == 322 {
            // 메일 없음
            view.showError(FindPasswordError.NO_SEARCH_MAIL)
        }
    }
}