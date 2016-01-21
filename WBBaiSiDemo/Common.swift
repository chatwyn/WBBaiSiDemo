//
//  Common.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

public let WBBgColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)

class Common:NSObject{
    /**
     创建一个barButtonItem
     */
   class func itemWithImage(image:UIImage,highlightImage:UIImage,target:UIViewController,action:Selector) -> UIBarButtonItem{
    
        let button = UIButton.init()
    
        button.setBackgroundImage(image, forState: .Normal)
        button.setBackgroundImage(highlightImage, forState: .Highlighted)
    
        button.sizeToFit()
    
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem.init(customView: button)
        
    }
    
}

