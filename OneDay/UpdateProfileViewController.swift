//
//  UpdateProfileViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

enum UpdateProfileError {
    case NAME
    case EMAIL
    case BIRTH
}

protocol UpdateProfileViewInput {
    func updateProfileSubmit(user: User, name: String?, email: String?, birth: NSDate)
}

protocol UpdateProfileViewOutput {
    func updateProfileSuccess()
    func updateProfileException(err: UpdateProfileError)
}

class UpdateProfileViewController: UIViewController, UpdateProfileViewOutput {

    var presenter: UpdateProfilePresenter!
    var user: User?
    var userDelegate: UpdateUserDelegate?
    
    @IBAction func onSubmitClick(sender: UIBarButtonItem) {
        if let user = user {
            presenter.updateProfileSubmit(user, name: nameLabel.text, email: mailLabel.text, birth: birthDatePicker.date)
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

    
    // UpdateProfileViewOutput
    
    func updateProfileException(err: UpdateProfileError) {
        switch err {
        case .EMAIL:
            let alert = UIAlertController(title: "에러", message: "메일 설정 실패", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        case .NAME:
            let alert = UIAlertController(title: "에러", message: "이름 설정 실패", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        case .BIRTH:
            let alert = UIAlertController(title: "에러", message: "생일 설정 실패", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        default:
            print("")
        }
    }
    
    func updateProfileSuccess() {
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

protocol UpdateUserDelegate {
    func updateUser(user: User)
}
