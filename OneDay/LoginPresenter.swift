//
//  LoginPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation


// 프레젠터는 다른 바이퍼 모듈과의 연결만을 담당한다.
class LoginPresenter: LoginViewInput, LoginInteractorOutput {
    
    weak var view: LoginViewOutput!
    
    var interactor: LoginInteractorInput!
    
    var wireframe: LoginWireframe!
    
    init (view: LoginViewOutput) {
        self.view = view
        
        interactor = LoginInteractor(output: self)
        wireframe = LoginWireframe(loginViewController: <#T##LoginViewController#>)
        
        SocketIOManager.create()
        SocketIOManager.socket!.once("connect", callback: {
            _ in
            if !DBManager.checkDB() {
                if !DBManager.initDB() {
                    view.showDBError()
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
    
    func login(id: String, password: String) {
        if id.isEmpty {
            view.showIdEmptyError()
            return
        }
        
        if password.isEmpty {
            view.showPasswordEmptyError()
            return
        }
        
        interactor.login(id, password: password)
    }
    
    
    // LoginInteractorOutput
    
    func loginSuccess(user: User) {
        wireframe.showTimeline(user)
    }
    
    func loginFailed(code: Int) {
        view.showLoginError(code)
    }
    
    func findId() {
        
    }
    
    func findPw() {
        
    }
}