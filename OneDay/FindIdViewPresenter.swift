//
//  FindIdViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

class FindIdPresenter: FindIdViewInput, FindIdInteractorOutput {
    
    var view: FindIdViewOutput!
    
    var interactor: FindIdInteractor!
    
    var wireframe: FindIdWireframe!
    
    // FindIdViewInput
    
    func notiViewDidLoad() {
        interactor.output = self
    }
    
    func findId(email: String?) -> Bool {
        if let email = email {
            if email.isEmpty {
                view.showError(FindIdError.MAIL_EMPTY)
                return false
            }
            
            if !email.containsString("@") {
                view.showError(FindIdError.INVALID_MAIL)
                return false
            }
            
            interactor.findId(email)
            return true
        }
        
        view.showError(FindIdError.MAIL_EMPTY)
        return false
    }
    
    // FindIdInteractorOutput
    
    func findIdSuccess(id: String) {
        view.showId(id)
    }
    
    func findIdFailed(code: Int) {
        if code == 321 {
            // 메일 없음
            view.showError(FindIdError.NO_SEARCH_MAIL)
        }
    }
}