//
//  FriendInteractor.swift
//  OneDay
//
//  Created by 이동규 on 2016. 9. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import Contacts

protocol FriendInteractorInput {
    func getContact(friends: [String])
}

protocol FriendInteractorOutput {
    func setContact(phoneNums: [String])
}

class FriendInteractor: FriendInteractorInput {
    
    var presenter: FriendPresenter?
    
    
    // FriendInteractorInput
    
    func getContact(friends: [String]) {
        var phoneNumbers = [String]()
        let store = CNContactStore()
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey])
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: {
                contact, stop in
                if let phoneNumContact = contact.phoneNumbers.first {
                    let num = phoneNumContact.value as! CNPhoneNumber
                    if let number = num.valueForKey("digits") {
                        phoneNumbers.append(number as! String)
                    }
                }
            })
        } catch let err {
            print(err)
        }
        
        presenter?.setContact(phoneNumbers)
    }
}
