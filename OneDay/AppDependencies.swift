//
//  AppDependencies.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class AppDependencies {
    
    let loginWireframe = LoginWireframe()
    
    init() {
        let rootWireframe = RootWireframe()
        
        let loginPresenter = LoginPresenter()
        let loginInteractor = LoginInteractor()
        
        loginInteractor.output = loginPresenter
        loginPresenter.interactor = loginInteractor
        loginPresenter.loginWireframe = loginWireframe
        
        
        let signUpPresenter = SignUpPresenter()
        let signUpInteractor = SignUpInteractor()
        let signUpWireframe = SignUpWireframe()
        
        signUpInteractor.output = signUpPresenter
        signUpPresenter.interactor = signUpInteractor
        signUpPresenter.wireframe = signUpWireframe
        signUpWireframe.signUpPresenter = signUpPresenter
        
        let findPasswordPresenter = FindPasswordPresenter()
        let findPasswordInteractor = FindPasswordInteractor()
        let findPasswordWireframe = FindPasswordWireframe()
        
        findPasswordPresenter.interactor = findPasswordInteractor
        findPasswordPresenter.wireframe = findPasswordWireframe
        findPasswordInteractor.presenter = findPasswordPresenter
        findPasswordWireframe.presenter = findPasswordPresenter
        
        let findIdPresenter = FindIdPresenter()
        let findIdInteractor = FindIdInteractor()
        let findIdWireframe = FindIdWireframe()
        
        findIdPresenter.interactor = findIdInteractor
        findIdPresenter.wireframe = findIdWireframe
        findIdWireframe.presenter = findIdPresenter
        findIdInteractor.output = findIdPresenter
        
        loginWireframe.findPasswordWireframe = findPasswordWireframe
        loginWireframe.findIdWireframe = findIdWireframe
        loginWireframe.signUpWireframe = signUpWireframe
        loginWireframe.rootWireframe = rootWireframe
        loginWireframe.loginPresenter = loginPresenter
    }
    
    func installRootViewControllerInWindow(window: UIWindow) {
        loginWireframe.presentLoginInterfaceFromWindow(window)
    }
}