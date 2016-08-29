//
//  ProfileViewCell.swift
//  OneDay
//
//  Created by 이동규 on 2016. 8. 15..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class ProfileViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var birthLabel: UILabel!
    
    var handler: UpdateProfileDelegate?
    
    @IBAction func onUpdateProfileClick(sender: UIButton) {
        
    }
    
    @IBAction func updateProfileImage(sender: UIButton) {
        if let handler = handler {
            handler.onPickImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol UpdateProfileDelegate {
    func onPickImage()
}
