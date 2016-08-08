//
//  InsertTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class InsertTimelineViewController: UIViewController, postNoticeHandler {

    var user: User?
    @IBOutlet weak var contentView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .Plain, target: self, action: "submit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func submit() {
        if let user = self.user {
            print("id = \(user.id)")
            print("name = \(user.name)")
            print("image = \(user.profileImageUri)")
            SocketIOManager.postNotice(user.id, name: user.name, images: [], content: contentView.text, userImage: user.profileImageUri, handler: self)
        }
    }
    
    func onPostNoticeSuccess() {
        print("노티스 작성 성공")
        navigationController?.popViewControllerAnimated(true)
    }
    
    func onPostNoticeException(code: Int) {
        print("노티스 작성 실패")
    }
}
