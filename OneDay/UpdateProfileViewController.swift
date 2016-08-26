//
//  UpdateProfileViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController, setNameHandler, setMailHandler {

    var user: User?
    var count = 0
    var userDelegate: UpdateUserDelegate?
    
    @IBAction func onSubmitClick(sender: UIBarButtonItem) {
        if let user = user {
            if let name = nameLabel.text {
                if !name.isEmpty && name != user.name {
                    print("setName")
                    SocketIOManager.setName(user.id, name: name, handler: self)
                    user.name = name
                    count += 1
                }
            }
            
            if let mail = mailLabel.text {
                if !mail.isEmpty && mail != user.email {
                    print("setMail")
                    SocketIOManager.setMail(user.id, mail: mail, handler: self)
                    user.email = mail
                    count += 1
                }
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var mailLabel: UITextField!
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            nameLabel.text = user.name
            mailLabel.text = user.email
            birthDatePicker.date = user.birth
        }
    }
    
    func onSetMailSuccess() {
        count -= 1
        if count == 0 {
            if let vc = navigationController {
                vc.popViewControllerAnimated(true)
                if let user = user {
                    if let delegate = userDelegate {
                        delegate.updateUser(user)
                    }
                }
            }
        }
    }
    
    func onSetNameSuccess() {
        count -= 1
        if count == 0 {
            if let vc = navigationController {
                vc.popViewControllerAnimated(true)
                if let user = user {
                    if let delegate = userDelegate {
                        delegate.updateUser(user)
                    }
                }
            }
        }
    }
    
    func onSetMailException() {
        let alert = UIAlertController(title: "에러", message: "메일 설정 실패", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func onSetNameException() {
        let alert = UIAlertController(title: "에러", message: "이름 설정 실패", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

protocol UpdateUserDelegate {
    func updateUser(user: User)
}
