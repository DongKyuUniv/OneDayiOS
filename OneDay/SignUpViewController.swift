//
//  SignUpViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 19..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, signUpHandler {
    
    var isKeyboardShow = false
    
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
        
        if let  phoneNum = phoneNum {
            if !phoneNum.isEmpty {
                if let number = Int(phoneNum) {
                } else {
                    showError("번호 형식이 맞지 않습니다.")
                }
            }
        }
        
        print("name = \(name)")
        if name.isEmpty {
            showError("이름을 입력하세요")
        } else if id.isEmpty {
            showError("아이디를 입력하세요")
        } else if password.isEmpty {
            showError("비밀번호를 입력하세요")
        } else if confirm.isEmpty {
            showError("비밀번호 확인을 입력하세요")
        } else if email.isEmpty {
            showError("이메일을 입력하세요")
        } else if password != confirm {
            showError("비밀번호가 일치하지 않습니다")
        } else {
            SocketIOManager.signUp(id, password: password, birth: birth, email: email, name: name, phone: phoneNum, handler: self)
        }
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
    
    func onSignUpSuccess() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func onSignUpException(code: Int) {
        if code == 300 {
            // 아이디 이미 있음
            let alert = UIAlertController(title: "회원가입", message: "이미 사용중인 아이디입니다.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
