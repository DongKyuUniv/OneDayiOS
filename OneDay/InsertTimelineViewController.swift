//
//  InsertTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class InsertTimelineViewController: UIViewController, postNoticeHandler, updateNoticeHandler {

    var user: User?
    var notice: Notice?
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBAction func onSubmitClick(sender: UIBarButtonItem) {
        if let user = self.user {
            if let notice = notice {
                // 수정
                notice.content = contentView.text
                SocketIOManager.updateNotice(notice, handler: self)
            } else {
                SocketIOManager.postNotice(user.id, name: user.name, images: [], content: contentView.text, userImage: user.profileImageUri, handler: self)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notice = notice {
            contentView.text = notice.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onPostNoticeSuccess() {
        print("노티스 작성 성공")
        navigationController?.popViewControllerAnimated(true)
    }
    
    func onPostNoticeException(code: Int) {
        print("노티스 작성 실패")
    }
    
    func onUpdateNoticeSuccess(notice: Notice) {
        print("노티스 업데이트 성공")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func onUpdateNoticeException(code: Int) {
        print("노티스 업데이트 실패")
    }
}
