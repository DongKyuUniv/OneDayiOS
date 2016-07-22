//
//  timeLineCardViewContent.swift
//  OneDay
//
//  Created by 김동희 on 2016. 7. 17..
//  Copyright © 2016년 이동규. All rights reserved.
//

import Foundation
import UIKit


class timeLineCardViewContent {
    
    // 프로필에 들어갈 이미지
    var img_profileImage : UIImage!
    
    // 이름칸에 들어갈 스트링
    var str_Name : String!
    
    // 시간에 들어갈 스트링
    var str_Time : String!
    
    // 내용에 들어갈 스트링
    var str_Content : String?
    
    // 내용 이미지에 들어갈 이미지
    var img_ContentImage : UIImage?
    
    init (profileImage : NSURL?, username : NSURL?, time : NSURL?, str_Content : NSURL?){
        
        
        // NSURL? 타입의 username이 nil이 아닌지 체크
        if let url = username{
            
            do{
                
                // nil체크 후, 해당 url에서 내용 String 호출
                str_Name = try String(contentsOfURL: url)
                
            }catch{
                
                
            }
            
        }else{
            
        }
        
        if let url = time{
            
            do{
                
                str_Time = try String(contentsOfURL: url)
                
            }catch{
                
                
            }
            
        }else{
            
        }
        
        // NSURL? 타입의 profileImage이 nil 체크
        if let url = profileImage{
            
            // 해당 URL에 있는 콘텐츠를 가져옴과 동시에 nil 체크
            if let data = NSData(contentsOfURL: url) {
                
                // 해당 콘텐츠를 img_profileImage에 대입
                self.img_profileImage = try UIImage(data: data)
                
            }
            
        }else{
            
            
        }

        if let url = str_Content{
            
            do{
             
                self.str_Content = try String(contentsOfURL: url)
                
            }catch{
                
            }
            
        }else{
            
            
        }
        
    }
    
    init (profileImage : NSURL?, username : NSURL?, time : NSURL?, img_ContentImage_Url : NSURL?){
        
        if let url = username{
            
            do{
                
                str_Name = try String(contentsOfURL: url)
                
            }catch{
                
                
            }
            
        }else{
            
          
        }
        
        if let url = time{
            
            do{
                
                str_Time = try String(contentsOfURL: url)
                
            }catch{
                
                
            }
            
        }else{
            
        }
        
        if let url = profileImage{
            
            if let data = NSData(contentsOfURL: url) {
                
                self.img_profileImage = try UIImage(data: data)
                
            }
            
        }else{
            
            
        }
        
        if let url = img_ContentImage_Url{
                
            if let data = NSData(contentsOfURL: url) {
                
                self.img_ContentImage = try UIImage(data: data)
                
            }
            
        }else{
            
        
        }
        

    }
    
}