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
    var comments: [Comment!] = []
    var notices: [String!] = []
}