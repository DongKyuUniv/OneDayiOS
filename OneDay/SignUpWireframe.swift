//
//  SignUpWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SignUpWireframe {
    
    var signUpPresenter: SignUpPresenter?
    var presentedViewController: UIViewController?
    
    func presentSignUpInterfaceFromViewController(viewController: UIViewController) {
        let newViewController = getSignUpViewController()
        newViewController.presenter = signUpPresenter!
        signUpPresenter?.view = newViewController
        
        viewController.navigationController?.pushViewController(newViewController, animated: true)
        
        presentedViewController = viewController
    }
    
    func getSignUpViewController() -> SignUpViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("SignUpViewController") as! SignUpViewController
        return vc
    }
    
    func dismissSignUpInterface() {
        presentedViewController?.navigationController?.popViewControllerAnimated(true)
    }
}
