//
//  SearchTimelinePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 9..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class SearchTimelinePresenter: SearchTimelineViewInput {
    
    var view: SearchTimelineViewOutput!
    
    var interactor: SearchTimelineInteractor!
    
    var wireframe: SearchTimelineWireframe!
    
    // SearchTimelineViewInput
    
    func search(user: User, content: String) {
        interactor.search(user, content: content)
    }
}
