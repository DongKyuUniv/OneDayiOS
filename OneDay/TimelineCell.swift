//
//  TimelineCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 4..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBAction func setting(sender: UIButton) {
    }
    
    @IBOutlet weak var created: UILabel!
    
    @IBOutlet weak var content: UILabel!
}
