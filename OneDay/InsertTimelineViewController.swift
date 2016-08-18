//
//  InsertTimelineViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class InsertTimelineViewController: UIViewController, postNoticeHandler, updateNoticeHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, removeImageDelegate {

    var user: User?
    var notice: Notice?
    var images = [UIImage]()
    
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if images.count == 0 {
            imageCollectionViewHeight.constant = 220
        }
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
                
                if images.count == 0 {
                    return
                }
                
                let url = NSURL(string: "http://windsoft-oneday.herokuapp.com/upload_images")
                if let url = url {
                    let request = NSMutableURLRequest(URL: url)
                    request.HTTPMethod = "POST"
                    
                    let boundary = "Boundary-\(NSUUID().UUIDString)"
                    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    
                    let image_data = UIImagePNGRepresentation(images[0])
                    
                    let body = NSMutableData()
                    let file_name = "test.jpg"
                    let mimetype = "image/jpeg"
                    
                    body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("Content-Disposition:form-data; name=\"test\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("hi\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    
                    
                    
                    body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("Content-Disposition:form-data; name=\"file\"; filename=\"\(file_name)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    body.appendData(image_data!)
                    body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    
                    
                    body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                    
                    request.HTTPBody = body
                    
                    let session = NSURLSession.sharedSession()
                    
                    let task = session.dataTaskWithRequest(request) {
                        (let data, let response, let error) in
                        guard let _:NSData = data, let _:NSURLResponse = response where error == nil else {
                            print("error = \(error)")
                            return
                        }
                        
                        let data_string = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("data_string = \(data_string)")
                    }
                    
                    task.resume()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let notice = notice {
            contentView.text = notice.content
        }
        
        imageCollectionView.dataSource = self
        imageCollectionViewHeight.constant = 0
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
    
    func onPostNoticeSuccess() {
        print("노티스 작성 성공")
        navigationController?.popViewControllerAnimated(true)
    }
    
    func onPostNoticeException(code: Int) {
        print("노티스 작성 실패")
    }
    
    func onUpdateNoticeSuccess(notice: Notice) {
        print("노티스 업데이트 성공")
        self.navigationController?.popViewControllerAnimated(true)
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
