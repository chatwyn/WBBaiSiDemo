//
//  CreamTool.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CreamTool {
    
    // 获得左侧的标签列表
    class func getCategory(successfulBlock:((obj:AnyObject)->())){
        
        HTTPTool.getData("http://api.budejie.com/api/api_open.php?a=tag_recommend&c=topic&action=sub") { obj -> Void in

            successfulBlock(obj:RecommendTag.tags(obj.array!)  as AnyObject)
        }
    }

}

