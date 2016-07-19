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
    var likes: [String!] = []
    var bads: [String!] = []
    var comments: [String!] = []
    var notices: [String!] = []
    
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
        let name = dict["userName"] as! String
        if keys.contains("birth") {
            self.birth = dict["birth"] as! NSDate
        }
        let id = dict["userId"] as! String
        let profileImageUri = dict["userImage"] as! String
        let email = dict["mail"] as! String
        let likes = dict["good"] as! [String]
        let bads = dict["bad"] as! [String]
        let comments = dict["comment"] as! [String]
        let notices = dict["notice"] as! [String]
    }
}