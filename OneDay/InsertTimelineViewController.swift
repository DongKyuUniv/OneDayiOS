//
//  InsertTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import SwiftHTTP


class InsertTimelineViewController: UIViewController, postNoticeHandler, updateNoticeHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, removeImageDelegate {

    var user: User?
    var notice: Notice?
    var images = [UIImage]()
    var imageUrls = [NSURL]()
    
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
        
        print("url = \(url)")
        print("localPath = \(localPath)")
        print("name = \(name)")
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
                SocketIOManager.updateNotice(notice, handler: self)
            } else {
                SocketIOManager.postNotice(user.id, name: user.name, images: [], content: contentView.text, userImage: user.profileImageUri, handler: self)
            }
        }
    }
    
    
    func toData(string: String) -> NSData {
        return string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func onPostNoticeSuccess(notice: Notice) {
        print("노티스 작성 성공")
        navigationController?.popViewControllerAnimated(true)
        
        do {
            var count = 0
            for url in imageUrls {
                let opt = try HTTP.POST("http://windsoft-oneday.herokuapp.com/upload_images", parameters: ["noticeId":notice.id, "file": Upload(fileUrl: url)])
                print("noticeId = \(notice.id)")
                opt.start {
                    response in
                    count = count + 1
                    if count == self.imageUrls.count {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    func onPostNoticeException(code: Int) {
        print("노티스 작성 실패")
    }
    
    func onUpdateNoticeSuccess(notice: Notice) {
        print("노티스 업데이트 성공")
        
        do {
            var count = 0
            for url in imageUrls {
                let opt = try HTTP.POST("http://windsoft-oneday.herokuapp.com/upload_images", parameters: ["file": url, "noticeId":notice.id])
                opt.start {
                    response in
                    count = count + 1
                    if count == self.imageUrls.count {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
        } catch let error as NSError {
            print("error = \(error)")
        }
    }
    
    func onUpdateNoticeException(code: Int) {
        print("노티스 업데이트 실패")
    }
    
    func removeImage(index: Int) {
        images.removeAtIndex(index)
        imageCollectionView.reloadData()
        if images.count == 0 {
            imageCollectionViewHeight.constant = 0
        }
    }
}
