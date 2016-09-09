//
//  FindPasswordViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

enum FindPasswordError {
    case MAIL_EMPTY
    case ID_EMPTY
    case INVALID_MAIL
    case NO_SEARCH_MAIL
}

protocol FindPasswordViewInput: class {
    func findPassword(id: String?, email: String?) -> Bool
}

protocol FindPasswordViewOutput: class {
    func showPassword(password: String)
    func showError(err: FindPasswordError)
}

class FindPasswordViewController: UIViewController, FindPasswordViewOutput {

    @IBOutlet var idInput: UITextField!
    
    @IBOutlet var mailInput: UITextField!
    
    @IBOutlet var passwordLabel: UILabel!
    
    var presenter: FindPasswordPresenter!
    
    let submitBtn = UIBarButtonItem()
    
    func submit() {
        presenter.findPassword(idInput.text, email: mailInput.text)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .Plain, target: self, action: #selector(submit))
        self.navigationItem.rightBarButtonItem?.tintColor = MAIN_RED
        self.navigationController?.navigationBar.tintColor = ULTRA_LIGHT_BLACK
    }
    
    func showPassword(password: String) {
        passwordLabel.text = password
    }
    
    func showError(err: FindPasswordError) {
        switch err {
        case .MAIL_EMPTY:
            showAlert("비밀번호 찾기 에러", message: "메일을 입력하세요")
        case .INVALID_MAIL:
            showAlert("비밀번호 찾기 에러", message: "메일 형식이 아닙니다")
        case .NO_SEARCH_MAIL:
            showAlert("비밀번호 찾기 에러", message: "입력하신 메일이 없습니다")
        case .ID_EMPTY:
            showAlert("비밀번호 찾기 에러", message: "아이디를 입력하세요")
        default:
            print("dd")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
