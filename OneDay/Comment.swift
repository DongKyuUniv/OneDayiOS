//
//  Comment.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class Comment {
    var id: String!
    var notice_id: String!
    var authorId: String!
    var authorProfileImage: String!
    var authorName: String!
    var content: String!
    var created: NSDate!
    
    init (id: String, notice_id: String, authorId: String, authorProfileImage: String!, authorName: String, content: String, created: NSDate) {
        self.id = id
        self.notice_id = notice_id
        self.authorId = authorId
        self.authorProfileImage = authorProfileImage
        self.authorName = authorName
        self.content = content
        self.created = created
    }
    
    init(dict: NSDictionary) {
        let keys = dict.allKeys as! [String]
        print("dict = \(dict)")
        print("keys = \(keys)")
        if keys.contains("notice_id") {
            self.notice_id = dict.valueForKey("notice_id") as! String
            print("notice_id = \(notice_id)")
        }
        
        if keys.contains("_id") {
            self.id = dict.valueForKey("_id") as! String
            print("_id = \(id)")
        }
        
        if keys.contains("content") {
            self.content = dict.valueForKey("content") as! String
            print("content = \(content)")
        }
        
        if keys.contains("date") {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            self.created = dateFormatter.dateFromString(dict.valueForKey("date") as! String)
        }
        
        if keys.contains("user_id") {
            self.authorId = dict.valueForKey("user_id") as! String
        }
        
        if keys.contains("name") {
            self.authorName = dict.valueForKey("name") as! String
        }
    }
}