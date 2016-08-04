//
//  TimelinePresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 3..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

class TimelinePresenter: TimelineUserActionListener {
    
    var view: TimelineView?
    
    init(view: TimelineView) {
        self.view = view
    }
    
    
}