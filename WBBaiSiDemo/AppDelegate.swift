//
//  AppDelegate.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow.init()
        
        let tabBarController = WBTabBarController.init()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        // 显示引导页
        GuideView.show()
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        let cache = KingfisherManager.sharedManager.cache
        cache.clearDiskCache()
        cache.clearMemoryCache()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p = touches.first?.locationInView(self.window)
        if CGRectContainsPoint(UIApplication.sharedApplication().statusBarFrame, p!){
            self.searchScrollViewInView(self.window!)
        }
        
    }
    
    
    func searchScrollViewInView(superView:UIView){
        
        for item in superView.subviews{
            if item.isKindOfClass(UIScrollView) && item.isShowingOnKeyWindow(){
                let scrollView = item as! UIScrollView
                var offset = scrollView.contentOffset
                offset.y = -scrollView.contentInset.top
                scrollView.setContentOffset(offset, animated: true)
            }
            

            self.searchScrollViewInView(item)
        }
    }
    
    
    
}

