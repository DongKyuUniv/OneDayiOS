//
//  FindIdInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 7..
//  Copyright © 2016년 이동규. All rights reserved.
//


protocol FindIdInteractorInput: class {
    func findId(mail: String)
}

protocol FindIdInteractorOutput: class {
    func findIdSuccess(id: String)
    func findIdFailed(code: Int)
}

class FindIdInteractor: FindIdInteractorInput, findIdHandler {
    
    var output: FindIdInteractorOutput!
    
    // FindIdInteractorInput
    
    func findId(mail: String) {
        SocketIOManager.findId(mail, handler: self)
    }
    
    func onFindIdSuccess(id: String) {
        output.findIdSuccess(id)
    }
    
    func onFindIdException(code: Int) {
        output.findIdFailed(code)
    }
}