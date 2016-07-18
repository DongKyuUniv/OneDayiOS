//
//  Comment.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class Comment {
    comment : [{ user_id: String, user_img:String, content: String, date : Date, name : String }],
    
    var notice_id: String!
    var authorId: String!
    var authorProfileImage: String!
    var authorName: String!
    var content: String!
    var created: NSDate!
}