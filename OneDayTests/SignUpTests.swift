//
//  SignUpTests.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest
@testable import OneDay

class SignUpTests: XCTestCase {

    var presenter: SignUpPresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = SignUpPresenter()
        presenter.view = SignUpViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignUp() {
        XCTAssertFalse(presenter.signUp(User(id: "", name: "", profileImageUri: "", birth: NSDate(), email: "", likes: [], bads: [], comments: [], notices: [], friends: [], phone: ""), password: "", confirm: ""), "유저 데이터에 아무것도 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "dd", confirm: "dd"), "아이디 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "dd", confirm: "dd"), "비밀번호 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "dd", confirm: "dd"), "이메일 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "", confirm: "dd"), "비밀번호 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "dd", confirm: ""), "비밀번호 확인 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "01033677355"), password: "dd", confirm: "ddf"), "비밀번호와 비밀번호 확인이 다름")
        
        XCTAssertTrue(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: ""), password: "dd", confirm: "dd"), "휴대폰 번호 입력하지 않음")
        
        XCTAssertFalse(presenter.signUp(User(id: "test", name: "test", profileImageUri: "", birth: NSDate(), email: "test@naver.com", likes: [], bads: [], comments: [], notices: [], friends: [], phone: "z01033677355"), password: "dd", confirm: "dd"), "휴대폰 번호 양식에 맞지않음")
    }
}
