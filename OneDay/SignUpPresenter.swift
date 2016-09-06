//
//  SignUpPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

class SignUpPresenter: SignUpViewInput, SignUpInteractorOutput {
    
    var view: SignUpViewOutput!
    
    var interactor = SignUpInteractor()
    
    
    
    // SignUpViewInput
    
    func notiViewDidLoad() {
        interactor.output = self
    }
    
    func signUp(user: User, password: String, confirm: String) -> Bool {
        if let  phoneNum = user.phone {
            if !phoneNum.isEmpty {
                if Int(phoneNum) != nil {
                } else {
                    view.showError(SignUpError.INVALID_PHONE)
                    return false
                }
            }
        }
        
        if user.name.isEmpty {
            view.showError(SignUpError.EMPTY_NAME)
        } else if user.id.isEmpty {
            view.showError(SignUpError.EMPTY_ID)
        } else if password.isEmpty {
            view.showError(SignUpError.EMPTY_PASSWORD)
        } else if confirm.isEmpty {
            view.showError(SignUpError.EMPTY_CONFIRM)
        } else if user.email.isEmpty {
            view.showError(SignUpError.EMPTY_EMAIL)
        } else if password != confirm {
            view.showError(SignUpError.PASSWORD_IS_NOT_EQUAL_CONFIRM)
        } else {
            interactor.signUpReqest(user, password: password)
            return true
        }
        return false
    }
    
    // SignUpIneteractorOutput
    
    func signUpSuccess() {
        view.showSignIn()
    }
    
    func signUpException(code: Int) {
        if code == 300 {
            // 아이디 이미 있음
            view.showError(SignUpError.ID_IS_ALREADY_USED)
        }
    }
}