//
//  ViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit


class ViewController: UIViewController, loginHandler {
    
    var user: User?
    
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!

    
    @IBAction func login(sender: UIButton) {
        let id = idInput.text
        let pw = pwInput.text
        
        if let userId = id {
            if let userPw = pw {
                if userId.isEmpty {
                    showAlert("로그인 에러", message: "아이디를 입력해주세요")
                    return
                }
                
                if userPw.isEmpty {
                    showAlert("로그인 에러", message: "비밀번호를 입력해주세요")
                    return
                }
                
                SocketIOManager.login(userId, pw: userPw, context: self)
            }
        }
    }
    
    @IBAction func signUp(sender: UIButton) {
    }
    
    @IBAction func findId(sender: UIButton) {
    }
    
    @IBAction func findPw(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketIOManager.create()
        SocketIOManager.socket!.once("connect", callback: {
            _ in
            if !DBManager.checkDB() {
                if !DBManager.initDB() {
                    self.showAlert("에러", message: "DB 생성에 문제가 발생했습니다.")
                }
            } else {
                if let user = UserDBManager.getUser() {
                    if user.id != nil && user.password != nil {
                        self.user = user
                        print("유저 아이디 = \(user.id)")
                        print("유저 비밀번호 = \(user.password)")
                        self.performSegueWithIdentifier("loginSuccess", sender: self)
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLoginSuccess(user: User) {
        print("로그인 성공")
        if UserDBManager.insertUserDB(user.id, password: user.password) {
            performSegueWithIdentifier("loginSuccess", sender: self)
        } else {
            showAlert("로그인 실패", message: "로그인 실패")
        }
    }
    
    func onLoginException(code: Int) {
        print("로그인 실패 = \(code)")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            print("segueId = \(segueId)")
            if segueId == "loginSuccess" {
                let navigationVC = segue.destinationViewController as! UINavigationController
                let tabBarVC = navigationVC.viewControllers.first as! MainViewController
                tabBarVC.user = user
            }
        }
    }
}

