//
//  TimelineImageCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 25..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var handler: ImageTabDelegate?
    
    override func layoutSubviews() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TimelineImageCell.imageTapped(_:)))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(img: AnyObject) {
        if let handler = handler {
            if let image = imageView.image {
                handler.imageTabbed(image)
            }
        }
    }
}


protocol ImageTabDelegate {
    func imageTabbed(image: UIImage)
}