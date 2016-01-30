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
    typealias FailBlock = (obj:NSError)->Void
    

    
    class func getData
        (urlStr:String,
        parameters:[String: AnyObject]? = nil,
        failBlock:FailBlock,
        successfulBlock:SuccessfulBlock) {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            Alamofire.request(.GET, urlStr, parameters: parameters)
                .responseJSON { response in
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        successfulBlock(obj: json)
                        
                    }else if let error = response.result.error{

                            failBlock(obj: error)

                        
                    }
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            
            
    }
}





