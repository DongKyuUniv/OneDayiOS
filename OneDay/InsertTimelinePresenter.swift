//
//  InsertTimelinePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class InsertTimelinePresenter: InsertTimelineViewInput, InsertTimelineInteractorOutput {
    
    var view: InsertTimelineViewOutput!
    
    var interactor: InsertTimelineInteractor!
    
    var wireframe: InsertTimelineWireframe!
    
    // InsertTimelineViewInput
    
    func updateNotice(notice: Notice, imageUrls: [NSURL]) {
        interactor.updateNotice(notice, imageUrls: imageUrls)
    }
    
    func insertNotice(user: User, content: String, imageUrls: [NSURL]) {
        interactor.insertNotice(user, content: content, imageUrls: imageUrls)
    }
    
    // InsertTimelineInteractorOutput
    
    func postNoticeComplete() {
        view.insertTimelineComplete()
    }
}
