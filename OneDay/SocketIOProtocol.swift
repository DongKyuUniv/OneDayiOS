//
//  SocketIOProtocol.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 19..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation

protocol loginHandler {
    func onLoginSuccess(user: User)
    func onLoginException(code: Int)
}

protocol signUpHandler {
    func onSignUpSuccess()
    func onSignUpException(code: Int)
}

protocol getAllNoticeHandler {
    func onGetAllNoticeSuccess(notices: [Notice])
    func onGetAllNoticeException(code: Int)
}

protocol postNoticeHandler {
    func onPostNoticeSuccess()
    func onPostNoticeException(code: Int)
}

protocol likeHandler {
    func onLikeSuccess()
    func onLikeException(code: Int)
}

protocol badHandler {
    func onBadSuccess()
    func onBadException(code: Int)
}

protocol commentHandler {
    func onCommentSucces()
    func onCommentException(code: Int)
}

protocol setImageHandler {
    func onSetImageSuccess()
    func onSetImageException(code: Int)
}

protocol removeNoticeHandler {
    func onRemoveNoticeSuccess(notice: Notice)
    func onRemoveNoticeException(code: Int)
}

protocol updateNoticeHandler {
    func onUpdateNoticeSuccess(notice: Notice)
    func onUpdateNoticeException(code: Int)
}