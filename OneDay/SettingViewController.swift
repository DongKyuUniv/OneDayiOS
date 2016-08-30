//
//  SettingViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 26..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import Contacts

class SettingViewController: UIViewController {

    @IBOutlet weak var lastContractSyncTimeLabel: UILabel!
    
    @IBAction func SyncContract(sender: UIButton) {
        // 동기화 버튼 클릭
        // 연락처 동기화
        let store = CNContactStore()
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey])
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: {contact, stop in
                print(contact.phoneNumbers)
            })
        } catch let err {
            print(err)
            let alert = UIAlertController(title: "에러", message: "에러", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "주소록 접근 실패", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
