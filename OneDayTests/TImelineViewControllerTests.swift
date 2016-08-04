//
//  TImelineViewControllerTests.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import XCTest
@testable import OneDay

class TImelineViewControllerTests: XCTestCase {
    
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        viewController = storyboard.instantiateInitialViewController() as! TimelineViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
