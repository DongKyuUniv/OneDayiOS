//
//  imageViewCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 18..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class imageViewCell: UICollectionViewCell {
    
    var index: Int?
    var handler: removeImageDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func removeImageClick(sender: UIButton) {
        if let index = index {
            if let handler = handler {
                handler.removeImage(index)
            }
        }
    }
}

protocol removeImageDelegate {
    func removeImage(index: Int)
}