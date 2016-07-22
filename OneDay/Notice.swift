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
    var images: [String!] = []
    var comments: [Comment!] = []
    var likes: [String!] = []
    var bads: [String!] = []
}