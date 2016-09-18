//
//  ProfileViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 14..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

protocol ProfileViewInput {
    func imagePickerController(localPath: String, user: User)
    func getProfile(user: User)
}

protocol ProfileViewOutput{
    func getProfile(notices: [Notice])
    func setProfileImage(filename: String)
}

class ProfileViewController: UITableViewController, UpdateUserDelegate, UpdateProfileDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileViewOutput {
    
    var presenter: ProfilePresenter!
    
    var notices: [Notice]?
    
    var user: User?
    
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
        if let user = user {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell") as! ProfileViewCell
                cell.nameLabel.text = user.name
                cell.emailLabel.text = user.email
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                
                cell.birthLabel.text = dateFormatter.stringFromDate(user.birth)
                if let profileImage = user.profileImageUri {
                    cell.profileImage.kf_setImageWithURL(NSURL(string: "\(imageURL)\(profileImage)"))
                }
                cell.handler = self
                return cell
            }
            if let notices = notices {
                return TimelineCell.cell(tableView, cellForRowAtIndexPath: indexPath, notice: notices[indexPath.row], user: user)
            }
        }
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = user {
            presenter.getProfile(user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
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
        if let user = user {
            let url = info[UIImagePickerControllerReferenceURL] as! NSURL
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let path = url.path as! NSString
            let name = path.lastPathComponent
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDir = paths.first as String!
            let localPath = documentDir + "/" + name
            
            let data = UIImagePNGRepresentation(image)
            data?.writeToFile(localPath, atomically: true)
            presenter.imagePickerController(localPath, user: user)
        }
    }
    
    // ProfileViewOutput
    
    func getProfile(notices: [Notice]) {
        self.notices = notices
        tableView.reloadData()
    }
    
    func setProfileImage(filename: String) {
        if let user = user {
            user.profileImageUri = filename
            if let delegate = self.userDelegate {
                delegate.updateUser(user)
            }
            self.tableView.reloadData()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
