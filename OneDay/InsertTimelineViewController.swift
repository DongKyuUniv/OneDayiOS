//
//  InsertTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import SwiftHTTP

protocol InsertTimelineViewInput {
    func updateNotice(notice: Notice, imageUrls: [NSURL])
    func insertNotice(user: User, content: String, imageUrls: [NSURL])
}

protocol InsertTimelineViewOutput {
    func insertTimelineComplete()
}


class InsertTimelineViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, removeImageDelegate, InsertTimelineViewOutput {

    var user: User?
    var notice: Notice?
    var images = [UIImage]()
    var imageUrls = [NSURL]()
    
    var presenter: InsertTimelinePresenter!
    
    let imagePicker: UIImagePickerController? = UIImagePickerController()
    
    @IBOutlet weak var imageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBAction func onTakePhotoClick(sender: UIButton) {
        // 사진 촬영 버튼 클릭
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                if let imagePicker = imagePicker {
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .Camera
                    imagePicker.cameraCaptureMode = .Photo
                    presentViewController(imagePicker, animated: true, completion: {})
                }
            } else {
                let alert = UIAlertController(title: "실패", message: "카메라가 존재하지 않습니다.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "실패", message: "카메라에 접근할 수 없습니다.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onChoicePhotoClick(sender: UIButton) {
        // 사진 선택 버튼 클릭
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            if let imagePicker = imagePicker {
                imagePicker.delegate = self
                imagePicker.sourceType = .SavedPhotosAlbum
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "실패", message: "앨범에 접근할 수 없습니다.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if images.count == 0 {
            imageCollectionViewHeight.constant = 220
        }
        
        let url = info[UIImagePickerControllerReferenceURL] as! NSURL
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let path = url.path! as NSString
        let name = path.lastPathComponent
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDir = paths.first as String!
        let localPath = documentDir + "/" + name
        
        let data = UIImageJPEGRepresentation(image, 0.5)
        data?.writeToFile(localPath, atomically: true)
        
        imageUrls.append(NSURL(fileURLWithPath: localPath))
        images.append(image)
        imageCollectionView.reloadData()
    }
    
    
    
    
    @IBAction func onSubmitClick(sender: UIBarButtonItem) {
        // 저장 버튼 클릭
        if let user = self.user {
            if let notice = notice {
                // 수정
                notice.content = contentView.text
                presenter.updateNotice(notice, imageUrls: imageUrls)
            } else {
                presenter.insertNotice(user, content: contentView.text, imageUrls: imageUrls)
            }
        }
    }
    
    
    func toData(string: String) -> NSData {
        return string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dddddd")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = ULTRA_LIGHT_BLACK
        
        if let notice = notice {
            contentView.text = notice.content
        }
        
        imageCollectionView.dataSource = self
        imageCollectionViewHeight.constant = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InsertTimelineViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InsertTimelineViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let size = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.CGRectValue() {
                self.view.frame.size.height -= size.height
            }
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let size = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue?)?.CGRectValue() {
                self.view.frame.size.height += size.height
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCollectionItem", forIndexPath: indexPath) as! imageViewCell
        cell.imageView.image = images[indexPath.row]
        cell.index = indexPath.row
        cell.handler = self
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeImage(index: Int) {
        images.removeAtIndex(index)
        imageCollectionView.reloadData()
        if images.count == 0 {
            imageCollectionViewHeight.constant = 0
        }
    }
    
    // InsertTimelineViewOutput
    func insertTimelineComplete() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
