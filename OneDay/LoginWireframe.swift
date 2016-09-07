//
//  LoginWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class LoginWireframe {
    
    var loginPresenter: LoginPresenter?
    var loginViewController: LoginViewController?
    var rootWireframe: RootWireframe?
    var signUpWireframe: SignUpWireframe?
    
    func presentLoginInterfaceFromWindow(window: UIWindow) {
        let viewController = loginViewControllerFromStoryboard()
        viewController.presenter = loginPresenter
        loginViewController = viewController
        loginPresenter?.view = loginViewController
        rootWireframe!.showRootViewController(viewController, window: window)
    }
    
    func presentSignUpInterface() {
        signUpWireframe?.presentSignUpInterfaceFromViewController(loginViewController!)
    }
    
    func loginViewControllerFromStoryboard() -> LoginViewController {
        let storybaord = mainStoryboard()
        let viewController = storybaord.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }
}