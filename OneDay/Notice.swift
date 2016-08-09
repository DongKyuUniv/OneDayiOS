//
//  Notice.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class Notice {
    var id: String!
    var author: String!
    var authorProfileImage: String!
    var authorName: String!
    var content: String!
    var created: NSDate!
    var images: [String] = []
    var comments: [Comment] = []
    var likes: [String] = []
    var bads: [String] = []
    
    
    init(data: NSDictionary) {
        let keys = data.allKeys as! [String]
        if keys.contains("notice_id") {
            let noticeId = data["notice_id"]
            if noticeId != nil && !(noticeId is NSNull) {
                id = noticeId as! String
                print("id = \(id)")
            }
        }
        
        if keys.contains("user_id") {
            let userId = data["user_id"]
            if userId != nil && !(userId is NSNull) {
                author = userId as! String
            }
        }
        
        if keys.contains("user_img") {
            let userImage = data["user_img"]
            if userImage != nil && !(userImage is NSNull) {
                authorProfileImage = userImage as! String
            }
        }
        
        if keys.contains("name") {
            let userName = data["name"]
            if userName != nil && !(userName is NSNull) {
                authorName = userName as! String
            }
        }
        
        if keys.contains("content") {
            let content = data["content"]
            if content != nil && !(content is NSNull) {
                self.content = content as! String
            }
        }
        
        if keys.contains("date") {
            let date = data["date"]
            if date != nil && !(date is NSNull) {
                let dateStr = date as! String
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                self.created = dateFormatter.dateFromString(dateStr)
            }
        }
        
        if keys.contains("img") {
            let img = data["img"]
            if img != nil && !(img is NSNull) {
                self.images = img as! [String]
            }
        }
        
        if keys.contains("comment") {
            let commentData = data["comment"]
            if commentData != nil && !(commentData is NSNull) {
                let commentJsonArray = commentData as! NSArray
                self.comments = commentJsonArray.map({
                    commentJsonObject -> Comment in
                    let comment = Comment(dict: commentJsonObject as! NSDictionary)
                    return comment
                })
            }
        }
        
        if keys.contains("good") {
            let good = data["good"]
            if good != nil && !(good is NSNull) {
                self.likes = good as! [String]
            }
        }
        
        if keys.contains("bad") {
            let bad = data["bad"]
            if bad != nil && !(bad is NSNull) {
                self.bads = bad as! [String]
            }
        }
    }
    
    
}