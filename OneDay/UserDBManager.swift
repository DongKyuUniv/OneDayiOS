//
//  File.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class UserDBManager {
    static let USER_TABLE = "USER"
    static let COL_ID = "id"
    static let COL_PASSWORD = "password"
    
    
    static func insertUserDB(id:String, password: String) -> Bool {
        let db = FMDatabase(path: DBManager.DB_PATH)
        if db.open() {
            let insertSQL = "INSERT INTO \(UserDBManager.USER_TABLE) VALUES ('\(id)', '\(password)');"
            let result = db.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if result {
                return true
            } else {
                print("user db insert error = \(db.lastErrorMessage())")
            }
            db.close()
        }
        return false
    }
    
    static func getUser() -> User! {
        let db = FMDatabase(path: DBManager.DB_PATH)
        if db.open() {
            let sql = "SELECT * FROM \(UserDBManager.USER_TABLE);"
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            if result.next() {
                var user: [String:String] = [:]
                user["id"] = result.stringForColumn("id")
                user["password"] = result.stringForColumn("password")
                return User(dict: user)
            }
            db.close()
        }
        return nil
    }
}