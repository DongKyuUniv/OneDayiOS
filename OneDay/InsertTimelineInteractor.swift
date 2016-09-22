//
//  InsertTimelineInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import SwiftHTTP

protocol InsertTimelineInteractorInput {
    func updateNotice(notice: Notice, imageUrls: [NSURL])
    func insertNotice(user: User, content: String, imageUrls: [NSURL])
}

protocol InsertTimelineInteractorOutput {
    func postNoticeComplete()
}

class InsertTimelineInteractor: InsertTimelineViewInput, updateNoticeHandler, postNoticeHandler {
    
    var presenter: InsertTimelinePresenter!
    var imageUrls: [NSURL]?
    
    // InsertTimelineViewInput
    
    func updateNotice(notice: Notice, imageUrls: [NSURL]) {
        SocketIOManager.updateNotice(notice, handler: self)
        self.imageUrls = imageUrls
    }
    
    func insertNotice(user: User, content: String, imageUrls: [NSURL]) {
        SocketIOManager.postNotice(user.id, name: user.name, images: [], content: content, userImage: user.profileImageUri, handler: self)
        self.imageUrls = imageUrls
    }
    
    
    // postNoticeHandler
    
    func onPostNoticeSuccess(notice: Notice) {
        print("노티스 작성 성공")
        if let imageUrls = imageUrls {
            if imageUrls.count == 0 {
                presenter.postNoticeComplete()
            }
            
            do {
                var count = 0
                for url in imageUrls {
                    let opt = try HTTP.POST("http://windsoft-oneday.herokuapp.com/upload_images", parameters: ["noticeId":notice.id, "file": Upload(fileUrl: url)])
                    print("noticeId = \(notice.id)")
                    opt.start {
                        response in
                        count = count + 1
                        if count == imageUrls.count {
                            self.presenter.postNoticeComplete()
                        }
                    }
                }
            } catch let error as NSError {
                print("error = \(error)")
            }
        } else {
            presenter.postNoticeComplete()
        }
    }
    
    func onPostNoticeException(code: Int) {
        print("노티스 작성 실패")
    }
    
    // updateNoticeHandler
    
    func onUpdateNoticeSuccess(notice: Notice) {
        print("노티스 업데이트 성공")
        
        if let imageUrls = imageUrls {
            if imageUrls.count == 0 {
                presenter.postNoticeComplete()
            }
            do {
                var count = 0
                for url in imageUrls {
                    let opt = try HTTP.POST("http://windsoft-oneday.herokuapp.com/upload_images", parameters: ["file": url, "noticeId":notice.id])
                    opt.start {
                        response in
                        count = count + 1
                        if count == imageUrls.count {
                            self.presenter.postNoticeComplete()
                        }
                    }
                }
            } catch let error as NSError {
                print("error = \(error)")
            }
        } else {
            presenter.postNoticeComplete()
        }
    }
    
    func onUpdateNoticeException(code: Int) {
        print("노티스 업데이트 실패")
    }
}
