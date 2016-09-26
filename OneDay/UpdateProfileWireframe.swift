//
//  UpdateProfileWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class UpdateProfileWireframe {
    var presenter: UpdateProfilePresenter!
    
    func presentUpdateProfileViewController(viewController: UIViewController, user: User) {
        let newViewController = getUpdateProfileViewController()
        newViewController.presenter = presenter
        newViewController.user = user
        presenter.view = newViewController
        viewController.presentViewController(newViewController, animated: true, completion: nil)
    }
    
    func getUpdateProfileViewController() -> UpdateProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("UpdateProfileViewController") as! UpdateProfileViewController
        return vc
    }
}
