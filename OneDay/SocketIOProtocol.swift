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
    func onGetAllNoticeSuccess()
    func onGetAllNoticeException(code: Int)
}