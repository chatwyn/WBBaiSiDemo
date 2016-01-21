//
//  User.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    
    /**  昵称  */
    var screen_name:String?
    /**  头像  */
    var header:String?
    /**  粉丝  */
    var fans_count:NSNumber?

//    "introduction" : "",
//    "uid" : "15129106",
//    "header" : "http:\/\/wimg.spriteapp.cn\/profile\/profile\/20150703135236.jpg",
//    "gender" : 0,
//    "is_vip" : false,
//    "fans_count" : "9188",
//    "tiezi_count" : 76,
//    "is_follow" : 0,
//    "screen_name" : "爱情保卫战"
    
    init(dic:JSON){
        super.init()
        screen_name = dic["screen_name"].stringValue
        header = dic["hearder"].stringValue
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
