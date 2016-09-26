//
//  RootWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class RootWireframe {
    func showRootViewController(viewController: UIViewController, window: UIWindow) {
        let navigationController = navigationControllerInWindow(window)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerInWindow(window: UIWindow) -> UINavigationController {
        return window.rootViewController as! UINavigationController
    }
}
