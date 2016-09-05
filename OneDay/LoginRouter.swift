//
//  LoginRouting.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 5..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

protocol LoginWireframeInput {
    func showSignUp()
    func showFindId()
    func showFindPw()
    func showTimeline()
}


// 라우터는 모듈들 사이의 항해를 담당한다.
class LoginWireframe: NSObject, LoginWireframeInput {
    
    func showSignUp() {
        
    }
    
    func showFindPw() {
        
    }
    
    func showFindId() {
        
    }
    
    func showTimeline() {
        
    }
}