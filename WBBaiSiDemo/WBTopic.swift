//
//  WBTopic.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/23.
//  Copyright © 2016年 曹文博. All rights reserved.
//  帖子的内容

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
    
    /**  id  */
    var id = ""
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
    /**  播放人数  */
    var playcount = 0
    /**  音频时长  */
    var voicetime = 0
    /**  视频时长  */
    var videotime = 0
    /**  最热评论  */
    var top_cmt:Comment?
    
    /**  cell 行高*/
    var cellHeight:CGFloat = 0
    /**  中间图片的frame（包括视频音频）  */
    var pictureFrame = CGRectZero
    /**  是否大图  */
    var isBigImage = false
    /**  图片下载进度  */
    var imageProgress:CGFloat = 0
    
    init(dic:JSON){
        super.init()
        
        self.id = dic["id"].stringValue
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
        self.playcount = dic["playcount"].intValue
        self.voicetime = dic["voicetime"].intValue
        self.videotime = dic["videotime"].intValue
        
        if !dic["top_cmt"].isEmpty{
            self.top_cmt =  Comment(dic: dic["top_cmt"][0])
        }
        
        let topic = self.text as NSString
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 30,CGFloat(MAXFLOAT))
        let textH = topic.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size.height
        // 只有文字时的高度
        self.cellHeight = textH + topicCellTextY + 2 * margin + cellBottomBtnH
        
        // 图片的宽度和高度 （包括视频和音频）
        let width = maxSize.width
        var height = self.height * width / self.width
        let top = topicCellTextY  + textH + margin
        
        // 当不为图片时
        if self.type != .Word {
            
            if self.type == .Picture{
                //  当为图片 并且高度太高时
                if height > cellPictureMaxImageH{
                    height = cellPictureModifiedH
                    self.isBigImage = true
                }
            }
            // 只要不是图片都有frame
            self.pictureFrame = CGRect(x: margin, y:top, width: width, height: height)
            self.cellHeight += height + margin
        }
        
        // 最热评论
        if let comment = self.top_cmt{
            let str = NSString.init(format: "%@:%@", comment.user!.username,comment.content) as String
            let commentH = str.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15)], context: nil).size.height
            self.cellHeight += hotCommentTitleH + commentH + margin
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
