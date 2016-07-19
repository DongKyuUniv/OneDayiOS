//
//  ViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 11..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ViewController: UIViewController, loginHandler {
    
    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!

    
    @IBAction func login(sender: UIButton) {
        let id = idInput.text
        let pw = pwInput.text
        
        if let userId = id {
            if let userPw = pw {
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
        
        SocketIOManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLoginSuccess(user: User) {
        print("로그인 성공")
    }
    
    func onLoginException(code: Int) {
        print("로그인 실패 = \(code)")
    }
}

