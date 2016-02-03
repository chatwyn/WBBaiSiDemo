//
//  Comment.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/31.
//  Copyright © 2016年 曹文博. All rights reserved.
//  评论

import UIKit
import SwiftyJSON

class Comment: NSObject {
    
    /**  id  */
    var id = ""
    /**  音频文件的时长  */
    var voicetime = 0
    /**  音频文件的路径  */
    var voiceuri:String = ""
    /**  评论的文字内容  */
    var content = ""
    /**  被点赞的数量  */
    var like_count = 0
    /**  用户  */
    var user:WBUser?
    /**  行高  */
    var cellHeight:CGFloat = 0
    
    init(dic:JSON){
        super.init()
        self.id = dic["id"].stringValue
        self.voicetime = dic["voicetime"].intValue
        self.voiceuri = dic["voiceuri"].stringValue
        self.content = dic["content"].stringValue
        self.like_count = dic["like_count"].intValue
        self.user = WBUser.init(dic: dic["user"])
        
        let topic = self.content as NSString
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 105,CGFloat(MAXFLOAT))
        let textH = topic.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size.height
        // 只有文字时的高度
        self.cellHeight = CGFloat(50) + textH
        
        if !self.voiceuri.isEmpty{
            self.cellHeight = 74
        }

        
        
    }
    
    class func comments(array:[JSON]) -> NSMutableArray{
        
        let arrayM = NSMutableArray()
        
        for item in array{
            arrayM.addObject(Comment.init(dic: item))
        }
        
        return arrayM
    }
    
}
