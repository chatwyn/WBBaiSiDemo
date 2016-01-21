//
//  HTTPTool.swift
//  WBDouBanFM
//
//  Created by caowenbo on 16/1/13.
//  Copyright © 2016年 曹文博. All rights reserved.
//  

import UIKit
import Alamofire
import SwiftyJSON

public class HTTPTool: NSObject {
    
    typealias SuccessfulBlock = (obj:JSON)->Void
    
    class func getData(urlStr:String,successfulBlock:SuccessfulBlock?) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, urlStr)
            .responseJSON { response in
                
                if let value = response.result.value {
                    if let successfulBlock = successfulBlock{
                        let json = JSON(value)
                        successfulBlock(obj: json)
                        
                    }
                }else{
                    SVProgressHUD.showErrorWithStatus("加载失败")
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        
    }
    
}




