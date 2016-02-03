//
//  CreamTool.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CreamTool {
    
    /**
     获得推荐标签
     */
    class func getCategory
        (parameters:[String: AnyObject]? = nil,
        failBlock:((obj:AnyObject)->())? = nil,
        successfulBlock:((obj:AnyObject)->())) {
            HTTPTool.getData("http://api.budejie.com/api/api_open.php?a=tag_recommend&c=topic&action=sub", failBlock: { (obj) -> Void in
                
                
                }) { (obj) -> Void in
                    successfulBlock(obj:RecommendTag.tags(obj.array!)  as AnyObject)
                    
            }
            
    }
    
    /**
     获得段子里的内容
     */
    class func getTopics
        (parameters:[String:AnyObject]?,
        successfulBlock:(obj:AnyObject)->()){
            
            HTTPTool.getData("http://api.budejie.com/api/api_open.php",parameters:parameters, failBlock: { (obj) -> Void in
                
                }) { (obj) -> Void in
                    
                    successfulBlock(obj:[WBTopic.topics(obj["list"].array!),obj["info"]["maxtime"].stringValue])
            }
    }
    
    class func getComments
        (parameters:[String:AnyObject]?,
        successfulBlock:(obj:AnyObject)->()){
            
            HTTPTool.getData("http://api.budejie.com/api/api_open.php",parameters:parameters, failBlock: { (obj) -> Void in
                
                }) { (obj) -> Void in

                    if obj == []{
                        successfulBlock(obj: [[],[],0])
                        return
                    }

                    print(Comment.comments(obj["hot"].array!))
                    
                    successfulBlock(obj:[Comment.comments(obj["hot"].array!),Comment.comments(obj["data"].array!),obj["total"].intValue])
            }
            
    }
    
    
}

