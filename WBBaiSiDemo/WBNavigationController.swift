//
//  WBNavigationController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    // MARK: - life cycle
    override class func initialize(){
        
        //设置naviBar背景图片
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(named: "navigationbarBackgroundWhite"), forBarMetrics: UIBarMetrics.Default)
        //设置title的字体
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:UIFont.systemFontOfSize(20)]


    }
    
    // MARK: - 拦截push的控制器
    override func pushViewController(viewController: UIViewController, animated: Bool) {

        if viewControllers.count > 0{
            
            //隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            viewController.navigationItem.leftBarButtonItem = setBackBarButtonItem()
        }
        
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - private method
    func setBackBarButtonItem() -> UIBarButtonItem{
        
        let button = UIButton.init(type: .Custom)
        button.setImage(UIImage.init(named: "navigationButtonReturn"), forState: .Normal)
        button.setImage(UIImage.init(named: "navigationButtonReturnClick"), forState: .Highlighted)
        button.setTitle("返回", forState: .Normal)
        button.setTitleColor(UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1), forState: .Normal)
        button.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        button.frame.size = CGSize(width: 100, height: 30)
        //  button 里的内容左对齐
        button.contentHorizontalAlignment = .Left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        
        return UIBarButtonItem.init(customView: button)
    }
    
    func back(){

        self.popViewControllerAnimated(true)
    }
}
