//
//  ImageDetailViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 25..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    @IBAction func onGoOut(sender: UIButton) {
        print("GoOUt")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
