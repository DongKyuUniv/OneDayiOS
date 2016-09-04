//
//  ImageDetailViewController.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 25..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var image: UIImage?
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        imageView = UIImageView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height))
        imageView.image = image
//        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.contentSize = imageView.bounds.size
        print("zoomScale = \(scrollView.zoomScale)")
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        self.view.sendSubviewToBack(scrollView)
    }
    
    @IBAction func onGoOut(sender: UIButton) {
        print("GoOUt")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
