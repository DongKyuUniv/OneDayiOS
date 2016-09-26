//
//  FindPasswordTests
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest
@testable import OneDay

class FindPasswordTests: XCTestCase {
    
    var presenter = FindPasswordPresenter()
    var view = FindPasswordViewController()
    
    override func setUp() {
        super.setUp()
        
        presenter.view = view
    }
    
    func testFindId() {
        XCTAssertTrue(presenter.findPassword("test", email: "test@naver.com"))
        XCTAssertFalse(presenter.findPassword("", email: "test@naver.com"))
        XCTAssertFalse(presenter.findPassword(nil, email: "test@naver.com"))
        XCTAssertFalse(presenter.findPassword("test", email: ""))
        XCTAssertFalse(presenter.findPassword("test", email: nil))
    }
}
