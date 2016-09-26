//
//  MainWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainWireframe {
    
    func presentMainViewController(view: UIViewController, user: User) {
        let mainView = getMainViewController()
        mainView.user = user
        view.presentViewController(mainView, animated: true, completion: nil)
    }
    
    func getMainViewController() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        return vc
    }
}
