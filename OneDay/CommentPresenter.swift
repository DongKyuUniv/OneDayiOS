//
//  CommentPresenter.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 22..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class CommentPresenter: CommentViewInput, CommentInteractorOutput {
    var view: CommentViewOutput!
    
    var interactor: CommentInteractor!
    
    var wireframe: CommentWireframe!
    
    // CommentViewInput
    
    func insertComment(user: User, notice: Notice, comment: String?) {
        
    }
}
