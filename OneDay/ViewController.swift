//
//  ViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ViewController: UIViewController, loginHandler, likeHandler, commentHandler {
    
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!

    
    @IBAction func login(sender: UIButton) {
        let id = idInput.text
        let pw = pwInput.text
        
        SocketIOManager.comment("test", noticeId: "5792c1ca5430f40300073734", comment: "댓글이다!", name: "lee", handler: self)
//        SocketIOManager.like("test", noticeId: "5792c1ca5430f40300073734", flag: true, handler: self)
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLoginSuccess(user: User) {
        print("로그인 성공")
        performSegueWithIdentifier("loginSuccess", sender: self)
    }
    
    func onLoginException(code: Int) {
        print("로그인 실패 = \(code)")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func onLikeSuccess() {
        print("좋아요 성공")
    }
    
    func onLikeException(code: Int) {
        print("좋아요 실패")
    }
    
    func onCommentSucces() {
        print("댓글달기 성공")
    }
    
    func onCommentException(code: Int) {
        print("댓글달기 실패")
    }
}

