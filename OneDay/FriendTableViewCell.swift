//
//  FriendTableViewCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 7. 16..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var friendRequestWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var numberOfSameFriends: UILabel!
    
    @IBAction func onClickFriendRequest(sender: UIButton) {
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
