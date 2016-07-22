//
//  SocketIO.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class SocketIOManager {
    static var socket: SocketIOClient? = nil
    
    init() {
        if SocketIOManager.socket == nil {
            SocketIOManager.socket = SocketIOClient(socketURL: NSURL(string: "http://windsoft-oneday.herokuapp.com")!, options: [.Log(true), .ForcePolling(true)])
            SocketIOManager.socket!.connect()
        }
    }
    
    static func login(id: String, pw: String, context: loginHandler) -> Void {
        do {
            let data = ["userId": id, "w": pw]
            let dataData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            let dataJson = try NSJSONSerialization.JSONObjectWithData(dataData, options: [])
            if let socket = self.socket {
                socket.emit("login", dataJson)
                socket.once("login") {
                    (res, ack) -> Void in
                    if let resJson = res[0] as AnyObject? {
                        if let code = resJson["code"] as? Int {
                            if code == 200 {
                                let user = User(dict: resJson as! NSDictionary)
                                context.onLoginSuccess(user)
                            } else {
                                context.onLoginException(code)
                            }
                        }
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func signUp(id: String, password: String, birth: NSDate, email: String, name: String, handler: signUpHandler) {
        do {
            let req = ["userId": id, "userPw": password, "userBirth": Int(birth.timeIntervalSince1970 * 1000), "userMail": email, "name": name]
            let reqData = try NSJSONSerialization.dataWithJSONObject(req, options: .PrettyPrinted)
            let reqJson = try NSJSONSerialization.JSONObjectWithData(reqData, options: [])
            print("reqJson = \(reqJson)")
            socket?.emit("signUp", reqJson)
            socket?.once("signUp") {
                data, ack in
                let res = data[0]
                let code = res["code"] as! Int
                if code == 200 {
                    handler.onSignUpSuccess()
                } else {
                    handler.onSignUpException(code)
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
}