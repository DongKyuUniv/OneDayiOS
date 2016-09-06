//
//  LoginRouting.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol LoginWireframeInput {
    func showSignUp()
    func showFindId()
    func showFindPw()
    func showTimeline(user: User)
}


// 라우터는 모듈들 사이의 항해를 담당한다.
class LoginWireframe: NSObject, LoginWireframeInput {
    
    weak var viewController: UIViewController!
    
    init(loginViewController vc: LoginViewController) {
        viewController = vc
    }
    
    func showSignUp() {
        
    }
    
    func showFindPw() {
        
    }
    
    func showFindId() {
        
    }
    
    func showTimeline(user: User) {
        viewController.performSegueWithIdentifier("loginSuccess", sender: self)
    }
}