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
    var comments: [String] = []
    var notices: [String] = []
    
    init(id: String, name: String, profileImageUri: String, birth: NSDate, email: String, likes: [String], bads: [String], comments:[String], notices: [String]) {
        self.id = id
        self.name = name
        self.profileImageUri = profileImageUri
        self.birth = birth
        self.email = email
        self.likes = likes.map({$0})
        self.bads = bads.map({$0})
        self.comments = comments.map({$0})
        self.notices = notices.map({$0})
    }
    
    init(dict: NSDictionary) {
        let keys = dict.allKeys as! [String]
        if keys.contains("userName") {
            let userName = dict["userName"]
            if userName != nil && !(userName is NSNull) {
                name = userName as! String
            }
        }
        if keys.contains("birth") {
            let userBirth = dict["birth"]
            if userBirth != nil && !(userBirth is NSNull) {
                birth = userBirth as! NSDate
            }
        }
        if keys.contains("userId") {
            let userId = dict["userId"]
            if userId != nil && !(userId is NSNull) {
                id = userId as! String
            }
        }
        if keys.contains("userImage") {
            let userImage = dict["userImage"]
            if userImage != nil && !(userImage is NSNull) {
                profileImageUri = userImage as! String
            }
        }
        
        if keys.contains("mail") {
            let userMail = dict["mail"]
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
            let userComments = dict["comment"]
            if userComments != nil && !(userComments is NSNull) {
                comments = userComments as! [String]
            }
        }
        
        if keys.contains("notice") {
            let userNotices = dict["notice"]
            if userNotices != nil && !(userNotices is NSNull) {
                notices = userNotices as! [String]
            }
        }
    }
}