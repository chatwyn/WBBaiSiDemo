//
//  NewestController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class NewestController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = UIImageView.init(image:UIImage.init(named: "MainTitle"))
        
        navigationItem.leftBarButtonItem = Common.itemWithImage(UIImage.init(named: "MainTagSubIcon")!,highlightImage:UIImage.init(named: "MainTagSubIconClick")!, target: self, action: "tagView")
        
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
