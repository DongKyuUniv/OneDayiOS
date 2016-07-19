//
//  SocketIO.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class SocketIOManager {
    var socket: SocketIOClient!
    
    init() {
        socket = SocketIOClient(socketURL: NSURL(string: "http://windsoft-oneday.herokuapp.com")!, options: [.Log(true), .ForcePolling(true)])
        socket.connect()
    }
    
    func login(id: String, pw: String, context: loginHandler) -> Void {
        do {
            let data = ["id": id, "pw": pw]
            let dataJson = try NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted)
            self.socket.emit("login", dataJson)
            self.socket.once("login") {
                (res, ack) -> Void in
                if let resJson = res[0] as AnyObject? {
                    if let code = resJson["code"] as? Int {
                        print("code = \(code)")
                        if code == 200 {
                            let name = resJson["userName"] as! String
                            let birth = resJson["birth"] as! NSDate
                            let id = resJson["userId"] as! String
                            let profileImageUri = resJson["userImage"] as! String
                            let email = resJson["mail"] as! String
                            let likes = resJson["good"] as! [String]
                            let bads = resJson["bad"] as! [String]
                            let comments = resJson["comment"] as! [String]
                            let notices = resJson["notice"] as! [String]
                            
                            let user = User(id: id, name: name, profileImageUri: profileImageUri, birth: birth, email: email, likes: likes, bads: bads, comments: comments, notices: notices)
                            context.onLoginSuccess(user)
                        } else {
                            context.onLoginException(code)
                        }
                    }
                }
                print("res = \(res)")
                print("ack = \(ack)")
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func signUp(id: String, password: String, birth: NSDate, email: String) {
        
    }
}