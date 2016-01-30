//
//  GuideView.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class GuideView: UIView {
    
    @IBAction func hide(sender: AnyObject) {
        removeFromSuperview()
    }
    
    // 显示引导页
    class func show() {
        
        let key = "CFBundleVersion"
        // 获得当前软件的版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary![key]?.integerValue
        // 获得沙盒中存储的版本号
        let lastVersion = NSUserDefaults.standardUserDefaults().integerForKey(key)
        
        if currentVersion != lastVersion{
        
            let window = UIApplication.sharedApplication().keyWindow
            let view = NSBundle.mainBundle().loadNibNamed("GuideView", owner: self, options: nil)[0] as! UIView
            
            view.frame = window!.bounds
            window!.addSubview(view)
            
            NSUserDefaults.standardUserDefaults().setInteger(currentVersion!, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    
}
