//
//  TimelineCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import Kingfisher

class TimelineCell: UITableViewCell, likeHandler, badHandler, UINavigationControllerDelegate, UICollectionViewDataSource {
    
    var notice: Notice?
    var user: User?
    var handler: OnCommentCellClickListener?
    var imageTabHandler: ImageTabDelegate?
    
    override func layoutSubviews() {
        imageCollectionView.dataSource = self
        
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBAction func setting(sender: UIButton) {
        if let handler = self.handler {
            if let notice = self.notice {
                handler.onSettingClick(notice)
            }
        }
    }
    
    @IBOutlet weak var created: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBAction func onLikeClick(sender: UIButton) {
        if let notice = self.notice {
            if let user = self.user {
                if notice.likes.contains(user.id) {
                    // 이미 좋아요 했다면
                    SocketIOManager.like(user.id, noticeId: notice.id, flag: false, handler: self)
                    notice.likes.removeAtIndex(notice.likes.indexOf(user.id)!)
                } else {
                    SocketIOManager.like(user.id, noticeId: notice.id, flag: true, handler: self)
                    notice.likes.append(user.id)
                }
                likeCount.text = "\(notice.likes.count)"
            }
        }
    }
    
    @IBAction func onHateClick(sender: UIButton) {
        if let notice = self.notice {
            if let user = self.user {
                if notice.bads.contains(user.id) {
                    // 이미 싫어요 했다면
                    SocketIOManager.bad(user.id, noticeId: notice.id, flag: false, handler: self)
                    notice.bads.removeAtIndex(notice.bads.indexOf(user.id)!)
                } else {
                    SocketIOManager.bad(user.id, noticeId: notice.id, flag: true, handler: self)
                    notice.bads.append(user.id)
                }
                badCount.text = "\(notice.bads.count)"
            }
        }
    }
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var badCount: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBAction func onCommentClick(sender: UIButton) {
        if let handler = self.handler {
            if let notice = self.notice {
                handler.onCommentClick(notice)
            }
        }
    }
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionViewHeight: NSLayoutConstraint!
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let notice = notice {
            imageCollectionViewHeight.constant = 220
            return notice.images.count
        }
        imageCollectionViewHeight.constant = 0
        return 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TimelimeImageCell", forIndexPath: indexPath) as! TimelineImageCell
        if let notice = notice {
            print("limage = \(notice.images[indexPath.row])")
            if let imageTabHandler = imageTabHandler {
                cell.handler = self.imageTabHandler
            }
            cell.imageView.kf_setImageWithURL(NSURL(string: "http://windsoft-oneday.herokuapp.com/images/\(notice.images[indexPath.row])"))
        }
        return cell
    }
    
    func onLikeSuccess() {
        print("좋아요 성공")
    }
    
    func onLikeException(code: Int) {
        print("좋아요 실패")
    }
    
    func onBadSuccess() {
        print("싫어오 성공")
    }
    
    func onBadException(code: Int) {
        print("싫어요 실패")
    }
}



protocol OnCommentCellClickListener {
    func onCommentClick(notice: Notice)
    func onSettingClick(notice: Notice)
}
