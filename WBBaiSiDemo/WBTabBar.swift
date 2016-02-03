//
//  WBTabBar.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class WBTabBar: UITabBar{
    
    let plusButton = UIButton.init(type: .Custom)
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        //添加加号按钮
        plusButton.setBackgroundImage(UIImage(named: "tabBar_publish_icon"), forState: .Normal)
        plusButton.setBackgroundImage(UIImage(named: "tabBar_publish_click_icon"), forState: .Highlighted)
        plusButton.addTarget(self, action: "presentView", forControlEvents: .TouchUpInside)
        
        addSubview(plusButton)
        
        //背景图片
        backgroundImage = UIImage.init(named: "tabbar-light")
        
    }
    
    /**
     点击加号
     */
    func presentView(){
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(PublishController(), animated: false, completion: nil)
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let width = frame.width * 0.2
        var buttonIndex:CGFloat = 0
        
        plusButton.sizeToFit()
        
        plusButton.center = CGPoint(x: self.center.x, y: self.frame.height * 0.5)
        
        for item in subviews{
            
            if item.isKindOfClass(NSClassFromString("UITabBarButton")!){
                
                item.frame = CGRect(x: width * (buttonIndex > 1 ? buttonIndex + 1 : buttonIndex), y: 0, width: width, height: item.frame.height)
                
                buttonIndex++
                
            }
        }
    }
    
}
