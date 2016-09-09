//
//  FindIdWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 8..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FindIdWireframe {
    
    var presenter: FindIdPresenter!
    
    var presentViewController: UIViewController?
    
    func presentFindIdViewController(viewController: UIViewController) {
        let newViewController = getFindIdViewController()
        newViewController.presenter = presenter
        presenter.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
        
        presentViewController = newViewController
    }
    
    func getFindIdViewController() -> FindIdViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("FindIdViewController") as! FindIdViewController
        return vc
    }
}