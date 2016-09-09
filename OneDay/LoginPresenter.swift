//
//  LoginPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//


// 프레젠터는 다른 바이퍼 모듈과의 연결만을 담당한다.
class LoginPresenter: LoginViewInput, LoginInteractorOutput {
    
    var view: LoginViewOutput!
    
    var interactor: LoginInteractorInput!
    
    var loginWireframe: LoginWireframe!
    
    init () {
        SocketIOManager.create()
        SocketIOManager.socket!.once("connect", callback: {
            _ in
            if !DBManager.checkDB() {
                if !DBManager.initDB() {
                    self.view.showDBError()
                }
            } else {
                if let user = UserDBManager.getUser() {
                    if user.id != nil && user.password != nil {
                        self.interactor.login(user.id, password: user.password)
                    }
                }
            }
        })
    }
    
    
    // LoginViewInput
    
    func login(id: String, password: String) -> Bool {
        if id.isEmpty {
            view.showIdEmptyError()
            return false
        }
        
        if password.isEmpty {
            view.showPasswordEmptyError()
            return false
        }
        
        interactor.login(id, password: password)
        return true
    }
    
    func signUpClick() {
        loginWireframe.presentSignUpInterface()
    }
    
    func findIdClick() {
        loginWireframe.presentFindIdInterface()
    }
    
    func findPwClick() {
        loginWireframe.presentFindPasswordInterface()
    }
    
    
    // LoginInteractorOutput
    
    func loginSuccess(user: User) {
        view.showTimeline(user)
    }
    
    func loginFailed(code: Int) {
        view.showLoginError(code)
    }
}