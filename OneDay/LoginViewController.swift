//
//  ViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

// 프레젠터 -> 뷰
protocol LoginViewOutput: class {
    func showIdEmptyError()
    func showPasswordEmptyError()
    func showLoginError(code: Int)
    func showDBError()
    func showTimeline(user: User)
}

// 뷰 -> 프레젠터
protocol LoginViewInput: class {
    func login(id: String, password: String) -> Bool
    func findIdClick()
    func findPwClick()
    func signUpClick()
}


class LoginViewController: UIViewController, LoginViewOutput {
    
    var user: User?
    
    var presenter: LoginPresenter!
    
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!

    
    @IBAction func login(sender: UIButton) {
        let id = idInput.text
        let pw = pwInput.text
        
        if let userId = id {
            if let userPw = pw {
                presenter.login(userId, password: userPw)
            }
        }
    }
    
    @IBAction func signUp(sender: AnyObject) {
        presenter.signUpClick()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let id = segue.identifier
        if let id = id {
            if id == "ShowTimelineSegue" {
                let tableVc = segue.destinationViewController as! MainViewController
                tableVc.user = self.user
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = NAV_BAR_BLACK
    }
    
    @IBAction func findId(sender: AnyObject) {
        presenter.findIdClick()
    }
    
    @IBAction func findPw(sender: AnyObject) {
        presenter.findPwClick()
    }
    
    func onLoginException(code: Int) {
        showAlert("로그인 실패", message: "로그인 실패")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func tab(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // LoginViewOutput
    
    func showIdEmptyError() {
        showAlert("로그인 에러", message: "아이디를 입력해주세요")
    }
    
    func showPasswordEmptyError() {
        showAlert("로그인 에러", message: "비밀번호를 입력해주세요")
    }
    
    func showLoginError(code: Int) {
        showAlert("로그인 에러", message: "로그인 에러")
        switch code {
        case 500:
            showAlert("dd", message: "dd")
        case 501:
            // db저장 실패
            showAlert("로그인 실패", message: "로그인 실패")
        default:
            print("dd")
        }
    }
    
    func showDBError() {
        self.showAlert("에러", message: "DB 생성에 문제가 발생했습니다.")
    }
    
    func showTimeline(user: User) {
        self.user = user
        self.performSegueWithIdentifier("ShowTimelineSegue", sender: self)
    }
}

