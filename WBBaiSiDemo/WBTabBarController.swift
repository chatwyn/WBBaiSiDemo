//
//  WBTabBarController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class WBTabBarController: UITabBarController {
    
    override class func initialize(){
        
        var attr = [String:AnyObject]()
        
        attr[NSForegroundColorAttributeName] = UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1)
        // 设置tabbarItem的字体选中的颜色
        UITabBarItem.appearance().setTitleTextAttributes(attr, forState:.Selected)

    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加所有子控制器
        addChildViewControllers()
        //设置tabbar
        setTabBar()
    }

    
    // MARK: - WBTabBar delegate
    func didTouchUp(PlusButton: UIButton) {
        print("didTouchUpPlusButton")
    }

    // MARK: - private method
    //添加所有子控制器
    func addChildViewControllers() {
        
        setChildrenController("精华", image: UIImage.init(named: "tabBar_essence_icon")!, selectedImage: UIImage.init(named: "tabBar_essence_click_icon")!,controller: CreamController.init())
        
        setChildrenController("最新", image: UIImage.init(named: "tabBar_new_icon")!, selectedImage: UIImage.init(named: "tabBar_new_click_icon")!,controller: NewestController.init())
        
        setChildrenController("关注", image: UIImage.init(named: "tabBar_friendTrends_icon")!, selectedImage: UIImage.init(named: "tabBar_friendTrends_click_icon")!,controller: AttentionController.init())
        
        setChildrenController("我", image: UIImage.init(named: "tabBar_me_icon")!, selectedImage: UIImage.init(named: "tabBar_me_click_icon")!,controller: MeController.init(style:.Grouped))
        
    }
    //设置tabbar
    func setTabBar() {
        
        let newTabBar = WBTabBar.init(frame: tabBar.bounds)

        setValue(newTabBar, forKey: "tabBar")
    }
    
    //添加一个子控制器
    private func setChildrenController(title:String,image:UIImage,selectedImage:UIImage,controller:UIViewController) {
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        controller.tabBarItem.selectedImage = selectedImage
        
        let naviController = WBNavigationController.init(rootViewController: controller)
        addChildViewController(naviController)
    }
    
    
    
    
}


