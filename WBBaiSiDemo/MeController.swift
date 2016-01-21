//
//  MeController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class MeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏标题
        navigationItem.title = "我的"
        
        navigationItem.rightBarButtonItems = [Common.itemWithImage(UIImage.init(named:"mine-setting-icon")!,highlightImage:UIImage.init(named: "mine-setting-icon-click")!, target: self, action: "tagView"),
            Common.itemWithImage(UIImage.init(named:"mine-moon-icon")!,highlightImage:UIImage.init(named: "mine-moon-icon-click")!, target: self, action: "tagView")]
        
        view.backgroundColor = WBBgColor
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
