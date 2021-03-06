//
//  User.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class User {
    var id: String!
    var name: String!
    var profileImageUri: String!
    var password: String!
    var birth: NSDate!
    var email: String!
    var likes: [String] = []
    var bads: [String] = []
    var comments: [Comment] = []
    var notices: [String] = []
    var friends: [String] = []
    var phone: String!
    
    init(id: String, name: String, profileImageUri: String, birth: NSDate, email: String, likes: [String], bads: [String], comments:[Comment], notices: [String], friends: [String], phone: String) {
        self.id = id
        self.name = name
        self.profileImageUri = profileImageUri
        self.birth = birth
        self.email = email
        self.likes = likes.map({$0})
        self.bads = bads.map({$0})
        self.comments = comments.map({$0})
        self.notices = notices.map({$0})
        self.friends = notices.map({$0})
        self.phone = phone
    }
    
    init(dict: [String:String]) {
        self.id = dict["id"]
        self.password = dict["password"]
    }
    
    init(dict: NSDictionary) {
        let keys = dict.allKeys as! [String]
        print("keys = \(keys)")
        if keys.contains("name") {
            let userName = dict["name"]
            print("name = \(userName)")
            if userName != nil && !(userName is NSNull) {
                name = userName as! String
            }
        }
        if keys.contains("birth") {
            let userBirth = dict["birth"]
            print("birth = \(userBirth)")
            if userBirth != nil && !(userBirth is NSNull) {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                birth = dateFormatter.dateFromString(userBirth as! String)
            }
        }
        if keys.contains("pw") {
            let userPassword = dict["pw"]
            if userPassword != nil && !(userPassword is NSNull) {
                password = userPassword as! String
            }
        }
        if keys.contains("user_id") {
            let userId = dict["user_id"]
            print("userId = \(userId)")
            if userId != nil && !(userId is NSNull) {
                id = userId as! String
            }
        }
        if keys.contains("image") {
            let userImage = dict["image"]
            print("image = \(userImage)")
            if userImage != nil && !(userImage is NSNull) {
                profileImageUri = userImage as! String
            }
        }
        
        if keys.contains("mail") {
            let userMail = dict["mail"]
            print("mail = \(userMail)")
            if userMail != nil && !(userMail is NSNull) {
                email = userMail as! String
            }
        }
        if keys.contains("good") {
            let userLikes = dict["good"]
            if userLikes != nil && !(userLikes is NSNull) {
                likes = userLikes as! [String]
            }
        }
        if keys.contains("bad") {
            let userBads = dict["bad"]
            if userBads != nil && !(userBads is NSNull) {
                bads = userBads as! [String]
            }
        }
        if keys.contains("comment") {
            if let userComments = dict["comment"] {
                if !(userComments is NSNull) {
                    let array = userComments as! NSArray
                    comments = array.map({
                        commentJson -> Comment in
                        let comment = Comment(dict: commentJson as! NSDictionary)
                        return comment
                    })
                }
            }
        }
        
        if keys.contains("notice") {
            let userNotices = dict["notice"]
            if userNotices != nil && !(userNotices is NSNull) {
                notices = userNotices as! [String]
            }
        }
        
        if keys.contains("friends") {
            if let userFriends = dict["friends"] {
                if !(userFriends is NSNull) {
                    self.friends = userFriends as! [String]
                }
            }
        }
        
        if keys.contains("phone") {
            if let userPhone = dict["phone"] {
                if !(userPhone is NSNull) {
                    self.phone = userPhone as! String
                }
            }
        }
    }
    
}