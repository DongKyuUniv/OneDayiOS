//
//  ProfileViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import SwiftHTTP

class ProfileViewController: TimelineViewController, getProfileHandler, UpdateUserDelegate, UpdateProfileDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userDelegate: UpdateUserDelegate?
    
    let imagePicker = UIImagePickerController()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let notices = notices {
                return notices.count
            }
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileViewCell
            if let user = user {
                cell.nameLabel.text = user.name
                cell.emailLabel.text = user.email
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                
                cell.birthLabel.text = dateFormatter.stringFromDate(user.birth)
                if let profileImage = user.profileImageUri {
                    cell.profileImage.kf_setImageWithURL(NSURL(string: "\(imageURL)\(profileImage)"))
                }
                cell.handler = self
            }
            return cell
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = user {
            SocketIOManager.getProfile(user.id, handler: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    func onGetProfileSuccess(notices: [Notice]) {
        self.notices = notices
        tableView.reloadData()
    }
    
    func onGetProfileException(code: Int) {
        print("getProfile 실패")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let id = segue.identifier {
            if id == "updateProfileSegue" {
                print("data 전송 성공")
                let vc = segue.destinationViewController as! UpdateProfileViewController
                vc.user = user
                vc.userDelegate = self
            }
        }
    }
    
    func updateUser(user: User) {
        self.user = user
        if let delegate = userDelegate {
            delegate.updateUser(user)
        }
        
        tableView.reloadData()
    }
    
    func onPickImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let url = info[UIImagePickerControllerReferenceURL] as! NSURL
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let path = url.path as! NSString
        let name = path.lastPathComponent
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDir = paths.first as String!
        let localPath = documentDir + "/" + name
        
        let data = UIImagePNGRepresentation(image)
        data?.writeToFile(localPath, atomically: true)
        
        print("user = \(user)")
        if let user = user {
            do {
                let fileURL = NSURL(fileURLWithPath: localPath)
                let opt = try HTTP.POST(UPLOAD_IMAGE_URL, parameters: ["userId": user.id, "file": Upload(fileUrl: fileURL)])
                opt.start { res in
                    let code = res.statusCode
                    let filename = res.text
                    if let code = code {
                        if code == 200 {
                            if let filename = filename {
                                user.profileImageUri = filename
                                SocketIOManager.getProfile(user.id, handler: self)
                                if let delegate = self.userDelegate {
                                    delegate.updateUser(user)
                                }
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            } catch let error {
                print(error)
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
