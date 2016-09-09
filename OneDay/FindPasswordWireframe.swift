//
//  FindPasswordWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 8..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FindPasswordWireframe {
    
    var presenter: FindPasswordPresenter?
    
    var presentedViewController: UIViewController?
    
    func presentFindPasswordViewController(viewController vc: UIViewController) {
        print("패스워드 찾기")
        let findPasswordViewController = getFindPasswordViewController()
        findPasswordViewController.presenter = presenter
        presenter!.view = findPasswordViewController
        
        vc.navigationController?.pushViewController(findPasswordViewController, animated: true)
        presentedViewController = vc
    }
    
    func dismissFindPasswordViewController() {
        presentedViewController?.navigationController?.popViewControllerAnimated(true)
    }
    
    func getFindPasswordViewController() -> FindPasswordViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("FindPasswordViewController") as! FindPasswordViewController
        return vc
    }
}
