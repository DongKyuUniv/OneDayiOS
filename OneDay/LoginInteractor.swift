//
//  LoginInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

// 데이터 모듈로부터 전달하는것이 가능하다.
protocol LoginInteractorInput: class {
    func login(id: String, password: String)
}

// 인터렉트 -> 프레젠터
protocol LoginInteractorOutput: class {
    func loginSuccess(user: User)
    func loginFailed(code: Int)
}


// 인터렉터는 비즈니스로직을 처리한다 (MVP패턴에서의 Model)
class LoginInteractor: LoginInteractorInput, loginHandler {
    
    var output: LoginInteractorOutput!
    
    init (output: LoginInteractorOutput) {
        self.output = output
    }
    
    func login(id: String, password: String) {
        SocketIOManager.login(id, pw: password, context: self)
    }
    
    func onLoginSuccess(user: User) {
        if UserDBManager.insertUserDB(user.id, password: user.password) {
            output.loginSuccess(user)
        } else {
            output.loginFailed(501)
        }
    }
    
    func onLoginException(code: Int) {
        output.loginFailed(code)
    }
}