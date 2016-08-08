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
    @IBAction func insertNotice(sender: UIBarButtonItem) {
        performSegueWithIdentifier("insertTimeline", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("아이디 = \(user?.id)")
        print("비밀번호 = \(user?.password)")
        print("이름 = \(user?.name)")
        
        if let vcs = viewControllers {
            let navigationVC = vcs[0] as! UINavigationController
            print("뷰컨트롤러 \(navigationVC.viewControllers)")
            let timelineVC = navigationVC.viewControllers[0] as! TimelineViewController
            timelineVC.user = user
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        print("id = \(id)")
        if id == "insertTimeline" {
            print("됌?")
            let vc = segue.destinationViewController as! InsertTimelineViewController
            vc.user = user
        }
    }
}
