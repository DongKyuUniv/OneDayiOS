//
//  LoginPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 6..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest
@testable import OneDay

class LoginPresenterTests: XCTestCase {

    var presenter: LoginPresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = LoginPresenter()
        presenter.view = LoginViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLogin() {
        XCTAssertFalse(presenter.login("", password: "test"), "아이디 Empty일 때 에러")
        XCTAssertFalse(presenter.login("test", password: ""), "비밀번호 Empty일 때 에러")
        XCTAssertFalse(presenter.login("", password: ""), "아이디, 비밀번호 모두 Empty일 때 에러")
        XCTAssert(presenter.login("test", password: "test"), "정상적으로 입력")
    }
}
