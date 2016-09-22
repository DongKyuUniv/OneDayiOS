//
//  ProfileInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import SwiftHTTP

protocol ProfileInteractorInput {
    func imagePickerController(localPath: String, user: User)
    func getProfile(user: User)
}

protocol ProfileInteractorOutput {
    func getProfile(notices: [Notice])
    func setProfileImage(filename: String)
}

class ProfileInteractor: ProfileInteractorInput, getProfileHandler {
    
    var presenter: ProfilePresenter?
    
    // ProfileInteractorInput
    
    func imagePickerController(localPath: String, user: User) {
        do {
            let fileURL = NSURL(fileURLWithPath: localPath)
            let opt = try HTTP.POST(UPLOAD_IMAGE_URL, parameters: ["userId": user.id, "file": Upload(fileUrl: fileURL)])
            opt.start { res in
                let code = res.statusCode
                let filename = res.text
                if let code = code {
                    if code == 200 {
                        if filename != nil {
                            SocketIOManager.getProfile(user.id, handler: self)
                            
                        }
                    }
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func getProfile(user: User) {
        SocketIOManager.getProfile(user.id, handler: self)
    }
    
    // getProfileHandler
    
    func onGetProfileSuccess(notices: [Notice]) {
        presenter?.getProfile(notices)
    }
    
    func onGetProfileException(code: Int) {
        print("getProfile 실패")
    }
}
