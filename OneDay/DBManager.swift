//
//  DBManager.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class DBManager: UIViewController {
    
    static var DB_PATH: String?
    
    
    static func checkDB() -> Bool {
        let fileManager = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        DBManager.DB_PATH = docsDir.stringByAppendingString("/oneDay.db")
        print("DB_PATH = \(DBManager.DB_PATH)")
        
        if let dbPath = DBManager.DB_PATH {
            return fileManager.fileExistsAtPath(dbPath)
        }
        return false
    }
    
    static func initDB() -> Bool {
        if let dbPath = DBManager.DB_PATH {
            let db = FMDatabase(path: dbPath)
            
            // instance로 DB 체크
            if db != nil {
                if db.open() {
                    if db.executeStatements("CREATE TABLE IF NOT EXISTS \(UserDBManager.USER_TABLE) (\(UserDBManager.COL_ID) TEXT PRIMARY KEY, \(UserDBManager.COL_PASSWORD) TEXT);") {
                        return true
                    }
                    db.close()
                }
            }
        }
        return false
    }
}
