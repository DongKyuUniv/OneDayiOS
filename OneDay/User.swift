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
}