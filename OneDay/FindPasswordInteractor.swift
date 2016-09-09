//
//  FindPasswordInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//


protocol FindPasswordInteractorInput: class {
    func findPassword(id: String, mail: String)
}

protocol FindPasswordInteractorOutput: class {
    func findPasswordSuccess(password: String)
    func findPasswordFailed(code: Int)
}

class FindPasswordInteractor: FindPasswordInteractorInput, findPasswordHandler {
    
    var presenter: FindPasswordInteractorOutput!
    
    // FindPasswordInteractorInput
    
    func findPassword(id: String, mail: String) {
        SocketIOManager.findPassword(userId: id, email: mail, handler: self)
    }
    
    func onFindPasswordSuccess(password: String) {
        presenter.findPasswordSuccess(password)
    }
    
    func onFindPasswordException(code: Int) {
        presenter.findPasswordFailed(code)
    }
}