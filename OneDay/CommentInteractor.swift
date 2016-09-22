//
//  CommentInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 22..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol CommentInteractorInput {
    func insertComment(user: User, notice: Notice, comment: String)
}

protocol CommentInteractorOutput {
    func insertCommentSuccess(comment: Comment)
    func insertCommentException(err: InsertCommentError)
}

class CommentInteractor: CommentInteractorInput, commentHandler {
    
    var presenter: CommentPresenter!
    
    var user: User?
    
    // CommentInteractorInput
    
    func insertComment(user: User, notice: Notice, comment: String) {
        SocketIOManager.comment(user.id, noticeId: notice.id, comment: comment, name: user.name, handler: self)
    }
    
    // commentHandler
    
    func onCommentSuccess(noticeId: String, commentId: String, content: String, created: NSDate) {
        if let user = user {
            presenter.insertCommentSuccess(Comment(id: commentId, notice_id: noticeId, authorId: user.id, authorProfileImage: user.profileImageUri, authorName: user.name, content: content, created: created))
        }
    }
    
    
    func onCommentException(code: Int) {
        presenter.insertCommentException(InsertCommentError.FAIL_TO_SERVER)
    }
}
