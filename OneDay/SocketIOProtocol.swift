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
    func onPostNoticeSuccess(notice: Notice)
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

protocol getUsersHandler {
    func onGetUserSuccess(users: [User])
    func onGetUserException(code: Int)
}

protocol getProfileHandler {
    func onGetProfileSuccess(notices: [Notice])
    func onGetProfileException(code: Int)
}

protocol getFriendProfileHandler {
    func onGetFriendProfileSuccess(user: [User])
    func onGetFriendProfileException(code: Int)
}

protocol getFriendReccommendHandler {
    func onGetFriendReccommendSuccess(user: [User])
    func onGetFriendReccommendException(code: Int)
}

protocol setNameHandler {
    func onSetNameSuccess()
    func onSetNameException()
}

protocol setProfileImageHandler {
    func onSetProfileImageSuccess()
    func onSetProfileImageException()
}

protocol setMailHandler {
    func onSetMailSuccess()
    func onSetMailException()
}