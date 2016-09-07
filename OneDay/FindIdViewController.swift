//
//  FindIdViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

enum FindIdError {
    case MAIL_EMPTY
    case INVALID_MAIL
    case NO_SEARCH_MAIL
}

protocol FindIdViewInput: class {
    func findId(email: String?) -> Bool
    func notiViewDidLoad()
}

protocol FindIdViewOutput: class {
    func showId(id: String)
    func showError(err: FindIdError)
}

class FindIdViewController: UIViewController, FindIdViewOutput {
    
    
    @IBOutlet var emailInput: UITextField!
    
    @IBOutlet var idLabel: UILabel!
    
    var presenter = FindIdPresenter()
    
    @IBAction func submit(sender: AnyObject) {
        presenter.findId(emailInput.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
    }
    
    
    // FindIdViewOutput
    
    func showId(id: String) {
        idLabel.text = id
    }
    
    func showError(err: FindIdError) {
        switch err {
        case .MAIL_EMPTY:
            showAlert("아이디 찾기 에러", message: "메일을 입력하세요")
        case .INVALID_MAIL:
            showAlert("아이디 찾기 에러", message: "메일 형식이 아닙니다")
        case .NO_SEARCH_MAIL:
            showAlert("아이디 찾기 에러", message: "입력하신 메일이 없습니다")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
