//
//  WBTopic.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/23.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import SwiftyJSON
/**
 帖子类型
 */
enum TopicType:Int {
    case All = 1
    case Video = 41
    case Sound = 31
    case Picture = 10
    case Word = 29
}

class WBTopic: NSObject {
    
    /**  名称  */
    var name = ""
    /**  头像  */
    var profile_image = ""
    /**  发帖时间  */
    var create_time = ""
    /**  文字内容  */
    var text = ""
    /**  顶的数量  */
    var ding = 0
    /**  踩的数量  */
    var cai = 0
    /**  转发的数量  */
    var repost = 0
    /**  评论的数量  */
    var comment = 0
    /**  是否为新浪加V用户  */
    var sina_v = false
    /**  图片的宽度  */
    var width:CGFloat = 0
    /**  图片的高度  */
    var height:CGFloat = 0
    /**  帖子的类型  */
    var type:TopicType = .All
    /**  图片的url  */
    var small_image = ""
    var large_image = ""
    var middle_image = ""
    
    /**  cell 行高*/
    var cellHeight:CGFloat = 0
    /**  图片空间的frame  */
    var pictureFrame = CGRectZero
    /**  是否大图  */
    var isBigImage = false
    
    init(dic:JSON){
        super.init()
        
        self.name = dic["name"].stringValue
        self.profile_image = dic["profile_image"].stringValue
        self.create_time = dic["create_time"].stringValue
        self.text = dic["text"].stringValue
        self.ding = dic["ding"].intValue
        self.repost = dic["repost"].intValue
        self.cai = dic["cai"].intValue
        self.comment = dic["comment"].intValue
        self.sina_v = dic["sina_v"].boolValue
        self.width = CGFloat(dic["width"].floatValue)
        self.height = CGFloat(dic["height"].floatValue)
        self.small_image = dic["image0"].stringValue
        self.large_image = dic["image1"].stringValue
        self.middle_image = dic["image2"].stringValue
        self.type = TopicType(rawValue: dic["type"].intValue)!
        
        
        
        let topic = self.text as NSString
        let textH = topic.boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width - 30,CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size.height
        // 只有文字时的高度
        self.cellHeight = textH + topicCellTextY + 2 * margin + cellBottomBtnH
        
        if self.type == .Picture {
            let width = UIScreen.mainScreen().bounds.width - 30
            var height = self.height * width / self.width
            let pictureY = topicCellTextY  + textH + margin
            if height > cellPictureMaxImageH{
                height = cellPictureModifiedH
                self.isBigImage = true
            }
            self.pictureFrame = CGRect(x: margin, y:pictureY, width: width, height: height)
            
            self.cellHeight += height + margin
        }

    }
    
    class func topics(array:[JSON]) -> NSMutableArray{
        
        let arrayM = NSMutableArray()
        
        for item in array{
            arrayM.addObject(WBTopic.init(dic: item))
        }
        
        return arrayM
    }
}
