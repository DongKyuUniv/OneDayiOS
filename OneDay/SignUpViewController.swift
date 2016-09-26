//
//  SignUpViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 19..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

enum SignUpError {
    case EMPTY_ID
    case EMPTY_PASSWORD
    case EMPTY_CONFIRM
    case EMPTY_EMAIL
    case EMPTY_BIRTH
    case EMPTY_NAME
    case PASSWORD_IS_NOT_EQUAL_CONFIRM
    case INVALID_PHONE
    case ID_IS_ALREADY_USED
}

protocol SignUpViewOutput: class {
    func showError(err: SignUpError)
}

protocol SignUpViewInput: class {
    func signUp(user: User, password: String, confirm: String) -> Bool
}

class SignUpViewController: UIViewController, SignUpViewOutput {
    
    var isKeyboardShow = false
    
    var presenter: SignUpPresenter!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var birthPicker: UIDatePicker!
    @IBOutlet weak var phone: UITextField!
    
    
    @IBAction func signUp(sender: UIButton) {
        let name = nameInput.text!
        let id = idInput.text!
        let password = passwordInput.text!
        let confirm = confirmInput.text!
        let email = emailInput.text!
        let birth = birthPicker.date
        let phoneNum = phone.text
        
        let user = User(id: id, name: name, profileImageUri: "", birth: birth, email: email, likes: [], bads: [], comments: [], notices: [], friends: [], phone: phoneNum!)
        presenter.signUp(user, password: password, confirm: confirm)
    }
    
    @IBAction func tab(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = ULTRA_LIGHT_BLACK
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardDidShow(sender: NSNotification) {
        if !isKeyboardShow {
            if let userInfo = sender.userInfo {
                if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue?)??.CGRectValue() {
                    scrollViewHeight.constant -= keyboardSize.height
                    
                    isKeyboardShow = true
                }
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if isKeyboardShow {
            if let userInfo = sender.userInfo {
                if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.CGRectValue() {
                    scrollViewHeight.constant += keyboardSize.height
                    
                    isKeyboardShow = false
                }
            }
        }
    }
    
    func showError(msg: String) {
        let alert = UIAlertController(title: "에러", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // SignUpViewOutput
    
    func showError(err: SignUpError) {
        switch err {
        case SignUpError.INVALID_PHONE:
            showError("번호 형식이 맞지 않습니다.")
        case SignUpError.EMPTY_NAME:
            showError("이름을 입력하세요")
        case SignUpError.EMPTY_ID:
            showError("아이디를 입력하세요")
        case SignUpError.EMPTY_PASSWORD:
            showError("비밀번호를 입력하세요")
        case SignUpError.EMPTY_CONFIRM:
            showError("비밀번호 확인을 입력하세요")
        case SignUpError.EMPTY_EMAIL:
            showError("이메일을 입력하세요")
        case SignUpError.PASSWORD_IS_NOT_EQUAL_CONFIRM:
            showError("비밀번호가 일치하지 않습니다")
        case SignUpError.ID_IS_ALREADY_USED:
            let alert = UIAlertController(title: "회원가입", message: "이미 사용중인 아이디입니다.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        default:
            print("dd")
        }
    }
}
