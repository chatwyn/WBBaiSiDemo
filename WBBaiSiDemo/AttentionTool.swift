//
//  AttentionTool.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import SwiftyJSON

class AttentionTool {
    
    // 获得左侧的标签列表
    class func getCategory(successfulBlock:((obj:AnyObject)->())){
        
        
        HTTPTool.getData("http://api.budejie.com/api/api_open.php?a=category&c=subscribe", failBlock: { (obj) -> Void in
            
            
            }) { (obj) -> Void in
                
                successfulBlock(obj: CategoryModel.categorys(obj["list"].array!) as AnyObject)
                
        }
        
        
    }
    
    // 获得右侧的用户列表
    class func getUsers(page:NSNumber,categoryId:NSNumber,successfulBlock:((obj:AnyObject)->())){
        
        HTTPTool.getData("http://api.budejie.com/api/api_open.php?a=list&c=subscribe&category_id=\(categoryId)", failBlock: { (obj) -> Void in
            
            
            }) { (obj) -> Void in
                successfulBlock(obj: User.users(obj["list"].array!) as AnyObject)
                
        }
    }
    
        
}