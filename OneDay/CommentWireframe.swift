//
//  CommentWireframe.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 22..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CommentWireframe {
    
    var presenter: CommentPresenter!
    
    func presentCommentViewController(viewController: UIViewController, user: User, notice: Notice) {
        let newViewController = getCommentViewController()
        newViewController.user = user
        newViewController.notice = notice
        newViewController.presenter = presenter
        presenter.view = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func getCommentViewController() -> CommentViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("CommentViewController") as! CommentViewController
        return vc
    }
}
