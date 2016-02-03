//
//  User.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//   推荐关注里的用户

import UIKit
import SwiftyJSON

class User: NSObject {
    
    /**  昵称  */
    var screen_name:String?
    /**  头像  */
    var header:String?
    /**  粉丝  */
    var fans_count:NSNumber?

    
    init(dic:JSON){
        super.init()
        screen_name = dic["screen_name"].stringValue
        header = dic["header"].stringValue
        fans_count = dic["fans_count"].numberValue
    
    }
    
    class func users(array:[JSON]) -> NSMutableArray{
        
        let arrayM = NSMutableArray()
        
        for item in array{
            arrayM.addObject(User.init(dic: item))
        }
        
        return arrayM
    }
}
