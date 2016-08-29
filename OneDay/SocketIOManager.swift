//
//  SocketIO.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

class SocketIOManager {
    static var socket: SocketIOClient? = nil
    
    static func create() {
        if SocketIOManager.socket == nil {
            SocketIOManager.socket = SocketIOClient(socketURL: NSURL(string: rootServerURL)!, options: [.Log(true), .ForcePolling(true)])
        }
        SocketIOManager.socket!.connect()
    }
    
    static func login(id: String, pw: String, context: loginHandler) -> Void {
        do {
            let data = ["userId": id, "userPw": pw]
            let dataData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            let dataJson = try NSJSONSerialization.JSONObjectWithData(dataData, options: [])
            if let socket = self.socket {
                socket.emit("login", dataJson)
                socket.once("login") {
                    (res, ack) -> Void in
                    if let resJson = res[0] as AnyObject? {
                        if let code = resJson["code"] as? Int {
                            if code == 200 {
                                print("resJson = \(resJson)")
                                let user = User(dict: resJson["user"] as! NSDictionary)
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
    
    static func signUp(id: String, password: String, birth: NSDate, email: String, name: String, phone: String?, handler: signUpHandler) {
        do {
            print("signUp \(phone)")
            let req = ["userId": id, "userPw": password, "userBirth": Int(birth.timeIntervalSince1970 * 1000), "userMail": email, "name": name, "phone": phone!]
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
                if (code == 200) {
                    let noticeJsonArray = resJson["notice"] as! NSArray
                    let notices = noticeJsonArray.map({
                        noticeJsonObject -> Notice in
                        let notice = Notice(data: noticeJsonObject as! NSDictionary)
                        return notice
                    })
                    handler.onGetAllNoticeSuccess(notices)
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
                if (code == 200) {
                    let noticeJsonArray = resJson["notice"] as! NSArray
                    let notices = noticeJsonArray.map({
                        noticeJsonObject -> Notice in
                        let notice = Notice(data: noticeJsonObject as! NSDictionary)
                        return notice
                    })
                    handler.onGetAllNoticeSuccess(notices)
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
                    let notice = Notice(data: resJson["notice"] as! NSDictionary)
                    handler.onPostNoticeSuccess(notice)
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
            let reqData = ["userId": userId, "noticeId": noticeId, "flag": flag]
            let reqJsonStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqJson = try NSJSONSerialization.JSONObjectWithData(reqJsonStr, options: [])
            socket?.emit("bad", reqJson)
            socket?.once("bad") {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onBadSuccess()
                } else {
                    handler.onBadException(code)
                }
            }
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    static func comment(userId: String, noticeId: String, comment: String, name: String, handler: commentHandler) {
        do {
            let reqData = ["userId": userId, "noticeId": noticeId, "comment": comment, "userName": name]
            let reqJsonStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqJson = try NSJSONSerialization.JSONObjectWithData(reqJsonStr, options: [])
            socket?.emit("insertComment", reqJson)
            socket?.once("insertComment") {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onCommentSucces()
                } else {
                    handler.onCommentException(code)
                }
            }
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    
    static func setProfileImage(id: String, fileUrl: String, handler: setImageHandler) {
        let req = NSMutableURLRequest(URL: NSURL(string: "http://windsoft-oneday.herokuapp.com/upload_profile_image")!)
        req.HTTPMethod = "POST"
        let postStr = "id=13"
        req.HTTPBody = postStr.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) {
            data, res, error in
            guard error == nil && data != nil else {
                print("error = \(error)")
                return
            }
            
            if let httpStatus = res as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("status code is not 200!!")
                print("res = \(res)")
            }
            
            let resStr = String(data: data!, encoding: NSUTF8StringEncoding)
            print("resStr = \(resStr)")
        }
        task.resume()
    }
    
    static func removeNotice(notice: Notice, handler: removeNoticeHandler) {
        let reqData = ["noticeId": notice.id]
        do {
            let reqJsonStr = try NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted)
            let reqJson = try NSJSONSerialization.JSONObjectWithData(reqJsonStr, options: [])
            socket?.emit("removeNotice", reqJson)
            socket?.once("removeNotice", callback: {
                data, aka in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onRemoveNoticeSuccess(notice)
                } else {
                    handler.onRemoveNoticeException(code)
                }
            })
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    static func updateNotice(notice: Notice, handler: updateNoticeHandler) {
        do {
            let reqData = ["noticeId": notice.id, "content": notice.content, "image": notice.images]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            socket?.emit("updateNotice", reqJson)
            socket?.once("updateNotice", callback: {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    handler.onUpdateNoticeSuccess(notice)
                } else {
                    handler.onUpdateNoticeException(code)
                }
            })
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func getUsers(keyword: String, handler: getUsersHandler) {
        do {
            let reqData = ["keyword": keyword]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            socket?.emit("getUsers", reqJson)
            socket?.once("getUsers", callback: {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    let userArray = resJson["user"] as! NSArray
                    var users: [User] = []
                    for userJson in userArray {
                        users.append(User(dict: userJson as! NSDictionary))
                    }
                    handler.onGetUserSuccess(users)
                } else {
                    handler.onGetUserException(code)
                }
            })
        } catch let err as NSError {
            print("error = \(err)")
        }
    }
    
    static func getProfile(userId: String, handler: getProfileHandler) {
        do {
            let reqData = ["userId": userId]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            if let socket = socket {
                socket.emit("profile", reqJson)
                socket.once("profile", callback: {
                    data, ack in
                    let resJson = data[0]
                    let code = resJson["code"] as! Int
                    if code == 200 {
                        let noticeArray = resJson["notice"] as! NSArray
                        let notices = noticeArray.map({
                            noticeJson in
                            return Notice(data: noticeJson as! NSDictionary)
                        })
                        handler.onGetProfileSuccess(notices)
                    } else {
                        handler.onGetProfileException(code)
                    }
                })
            }
        } catch let err as NSError {
            print("err = \(err)")
        }
    }
    
    static func getFriendProfile(friends: [String], handler: getFriendProfileHandler) {
        do {
            let reqData = ["users": friends]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            socket?.emit("getFriendProfile", reqJson)
            socket?.once("getFriendProfile", callback: {
                data, ack in
                let resJson = data[0]
                let code = resJson["code"] as! Int
                if code == 200 {
                    let friendArray = resJson["friends"] as! NSArray
                    let friends = friendArray.map({
                        friendJson in
                        return User(dict: friendJson as! NSDictionary)
                    })
                    handler.onGetFriendProfileSuccess(friends)
                } else {
                    handler.onGetFriendProfileException(code)
                }
            })
        } catch let err as NSError {
            print(err)
        }
    }
    
    
    static func setName(userId: String, name: String, handler: setNameHandler) {
        do {
            let reqData = ["userId": userId, "userName": name]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            if let socket = socket {
                socket.emit("setName", reqJson)
                socket.once("setName", callback: {
                    data, ack in
                    let resJson = data[0]
                    let code = resJson["code"] as! Int
                    if code == 200 {
                        handler.onSetNameSuccess()
                    } else {
                        handler.onSetNameException()
                    }
                })
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func setMail(userId: String, mail: String, handler: setMailHandler) {
        do {
            let reqData = ["userId": userId, "userMail": mail]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            if let socket = socket {
                socket.emit("setMail", reqJson)
                socket.once("setMail", callback: {
                    data, ack in
                    let resJson = data[0]
                    let code = resJson["code"] as! Int
                    if code == 200 {
                        handler.onSetMailSuccess()
                    } else {
                        handler.onSetMailException()
                    }
                })
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func setBirth(userId: String, birth: NSDate, handler: setBirthHandler) {
        do {
            let reqData = ["userId": userId, "userBirth": Int(birth.timeIntervalSince1970 * 1000)]
            let reqJson = try NSJSONSerialization.JSONObjectWithData(NSJSONSerialization.dataWithJSONObject(reqData, options: .PrettyPrinted), options: [])
            if let socket = socket {
                socket.emit("setBirth", reqJson)
                socket.once("setBirth", callback: { data, ack in
                    let resJson = data[0]
                    let code = resJson["code"] as! Int
                    if code == 200 {
                        handler.onSetBirthSuccess()
                    } else {
                        handler.onSetBirthException()
                    }
                })
            }
        } catch let error {
            print(error)
        }
    }
}