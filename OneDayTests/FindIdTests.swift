//
//  FindIdTests.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest
@testable import OneDay

class FindIdTests: XCTestCase {

    var presenter = FindIdPresenter()
    var view = FindIdViewController()
    
    override func setUp() {
        super.setUp()
        
        presenter.view = view
    }
    
    func testFindId() {
        XCTAssertTrue(presenter.findId("dkenl135@naver.com"))
        XCTAssertFalse(presenter.findId(""))
        XCTAssertFalse(presenter.findId("dkenl135naver.com"))
        XCTAssertFalse(presenter.findId(nil))
    }
}
