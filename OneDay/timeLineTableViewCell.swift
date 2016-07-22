//
//  timeLineTableViewCell.swift
//  OneDay
//
//  Created by 김동희 on 2016. 7. 12..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class timeLineTableViewCell: UITableViewCell {
    
    
    // ImageView - Profile Pic
    @IBOutlet weak var iv_profilePhoto: UIImageView!
    
    // Label - name
    @IBOutlet weak var lb_NameLabel: UILabel!
    
    // Label - time
    @IBOutlet weak var lb_TimeLabel: UILabel!
    
    // Label - Content
    @IBOutlet weak var lb_Content: UILabel!
    
    // ImageView - Content Image
    @IBOutlet weak var iv_Content_Image: UIImageView!
    
    // Button - Option Button
    @IBAction func optionEventButton(sender: AnyObject) {
       
        let alert = UIAlertController(title: "설정", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        // 삭제 이벤트 구현하기!
        alert.addAction(UIAlertAction(title: "삭제", style: UIAlertActionStyle.Default , handler:
            {(alert: UIAlertAction!) in
                //서버에 내용삭제 명령 보내기, 후에 코드 작성해야함
                }))
        
        // 설정 이벤트 구현하기!
        alert.addAction(UIAlertAction(title: "설정", style: UIAlertActionStyle.Default, handler: nil ))
        
        // tableView.reloadData <- 테이블 뷰 갱신 ( 애니메이션 x )
        // 테이블 뷰 클래스 이름에 맞춰 넣기
        
    }

    private func settingCells(alert : UIAlertAction!) -> Void {
        // 셀 세팅 
        // 밑에 코드 채워넣기
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
