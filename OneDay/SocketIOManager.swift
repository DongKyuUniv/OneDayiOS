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
    
    static func create() {
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
    
    
    static func getAllNotices(userId: String, count: Int, time: NSDate, handler: getAllNoticeHandler) {
        do {
            let reqData = ["userId": userId, "count": count, "time": Int(time.timeIntervalSince1970 * 1000)]
            let reqDataStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqDataJson = try NSJSONSerialization.JSONObjectWithData(reqDataStr, options: [])
            socket?.emit("getAllNotices", reqDataJson)
            socket?.once("getAllNotices") {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                let count = resJson["count"] as! Int
                if (code == 200) {
                    let noticeJsonArray = resJson["notice"] as! NSArray
                    let notices = noticeJsonArray.map({
                        noticeJsonObject -> Notice in
                        let notice = Notice(data: noticeJsonObject as! NSDictionary)
                        return notice
                    })
                } else {
                    handler.onGetAllNoticeException(code)
                }
            }
        } catch let error as NSError {
            print("getAllNotices Error = \(error)")
            print("getAllNotices Error = \(error.code)")
//            socket?.connect()
        }
    }
    
    
    static func getAllNotices(userId: String, count: Int, time: NSDate, keyword:String, handler: getAllNoticeHandler) {
        do {
            let reqData = ["userId": userId, "count": count, "time": Int(time.timeIntervalSince1970 * 1000), "keyWord": keyword]
            let reqDataStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqDataJson = try NSJSONSerialization.JSONObjectWithData(reqDataStr, options: [])
            socket?.emit("getAllNotices", reqDataJson)
            socket?.once("getAllNotices") {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                let count = resJson["count"] as! Int
                if (code == 200) {
                    let noticeJsonArray = resJson["notice"] as! NSArray
                    let notices = noticeJsonArray.map({
                        noticeJsonObject -> Notice in
                        let notice = Notice(data: noticeJsonObject as! NSDictionary)
                        return notice
                    })
                } else {
                    handler.onGetAllNoticeException(code)
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    static func postNotice(userId: String, name: String, images: [String], content: String, userImage: String?, handler: postNoticeHandler) {
        do {
            var reqData: [String: AnyObject]
            if let userImg = userImage {
                reqData = ["userId" : userId, "userName": name, "image": images, "content": content, "userImg": userImg]
            } else {
                reqData = ["userId" : userId, "userName": name, "image": images, "content": content, "userImg": ""]
            }
            let reqDataJsonStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqDataJson = try NSJSONSerialization.JSONObjectWithData(reqDataJsonStr, options: [])
            socket?.emit("postNotice", reqDataJson)
            socket?.once("postNotice") {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onPostNoticeSuccess()
                } else {
                    handler.onPostNoticeException(code)
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    static func like(userId: String, noticeId: String, flag: Bool, handler: likeHandler) {
        do {
            let reqData = ["userId": userId, "noticeId": noticeId, "flag": flag]
            let reqJsonStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqJson = try NSJSONSerialization.JSONObjectWithData(reqJsonStr, options: [])
            socket?.emit("good", reqJson)
            socket?.once("good") {
                data, ack in
                let resJson = data[0]
                print("resJson = \(resJson)")
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onLikeSuccess()
                } else {
                    handler.onLikeException(code)
                }
            }
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    
    static func bad(userId: String, noticeId: String, flag: Bool, handler: badHandler) {
        do {
            
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
}