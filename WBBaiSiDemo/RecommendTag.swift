//
//  RecommendTag.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//  推荐的标签

import UIKit
import SwiftyJSON

class RecommendTag: NSObject {
    
    /**  图片  */
    var image_list = ""
    /**  名字  */
    var theme_name = ""
    /**  订阅数  */
    var sub_number:NSNumber?
    
    init(dic:JSON){
        super.init()
        self.image_list = dic["image_list"].stringValue
        self.theme_name = dic["theme_name"].stringValue
        self.sub_number = dic["sub_number"].numberValue
        
    }
    
    class func tags(array:[JSON]) -> NSMutableArray{
        
        let arrayM = NSMutableArray()
        
        for item in array{
            arrayM.addObject(RecommendTag.init(dic: item))
        }
        
        return arrayM
    }
}

