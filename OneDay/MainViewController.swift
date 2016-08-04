//
//  MainViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("아이디 = \(user?.id)")
        print("비밀번호 = \(user?.password)")
        
        print("뷰컨트롤러 \(viewControllers)")
        if let vcs = viewControllers {
            let timelineVC = vcs[0] as! TimelineViewController
            timelineVC.user = user
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
