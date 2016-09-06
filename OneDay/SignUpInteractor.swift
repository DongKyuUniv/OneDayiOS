//
//  SignUpInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol SignUpInteractorInput: class {
    func signUpReqest(user: User, password: String)
}

protocol SignUpInteractorOutput: class {
    func signUpSuccess()
    func signUpException(code: Int)
}

class SignUpInteractor: SignUpInteractorInput, signUpHandler {
    
    var output: SignUpInteractorOutput!
    
    // SignUpIneteractorInput
    
    func signUpReqest(user: User, password: String) {
        SocketIOManager.signUp(user.id, password: password, birth: user.birth, email: user.email, name: user.name, phone: user.phone, handler: self)
    }
    
    
    // signUpHandler
    
    func onSignUpSuccess() {
        output.signUpSuccess()
    }
    
    func onSignUpException(code: Int) {
        output.signUpException(code)
    }
}