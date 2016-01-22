//
//  CreamController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//  精华controller

import UIKit

class CreamController: UIViewController {
    
    /**  现在所在的页面  */
    var currentPage:UIButton?
    /**  titleView下边的红线  */
    var indicateLine:UIView?
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置naviBar
        setUpNaviBar()
        // 添加titleView
        setUpTitleView()
        
    }
    
    
    // MARK: - event response
    
    //  打开 推荐标签 leftBarButtonItem
    func tagView(){
        navigationController?.pushViewController(RecommendTagController.init(), animated: true)
    }
    
    // MARK: - private method
    
    /**
    添加titleView
    */
    func setUpTitleView (){
        
        let titleView = UIView.init(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: 40))
        titleView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        view.addSubview(titleView)
        
        indicateLine = UIView.init(frame: CGRect(x: 0, y: 38, width: 20, height: 2))
        indicateLine?.backgroundColor = UIColor.redColor()
        titleView.addSubview(indicateLine!)
        
        let contentCount = 5
        
        let width = view.frame.width * 0.2
        let height = titleView.frame.height
        
        let array = ["全部","视频", "声音", "图片", "段子"]
        for var i = 0; i < contentCount; i++ {
            
            let button = UIButton.init(type: .Custom)
            button.tag = i
            button.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            button.setTitle(array[i], forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Disabled)
            
            button.addTarget(self, action:"didTouchTitleBtn:" , forControlEvents: .TouchUpInside)
            titleView.addSubview(button)
            
            if i == 0 {
                didTouchTitleBtn(button)
                button.titleLabel?.sizeToFit()
                self.indicateLine!.frame.size.width = button.titleLabel!.frame.width
                self.indicateLine!.center.x = button.center.x
            }
        }
        
    }
    
    func didTouchTitleBtn(sender: UIButton) {
        
        self.currentPage?.enabled = true
        self.currentPage = sender
        
        sender.enabled = false
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.indicateLine!.frame.size.width = sender.titleLabel!.frame.width
            self.indicateLine!.center.x = sender.center.x
        }

        
    }
    
    /**
     设置naviBar
     */
    func setUpNaviBar() {
        
        navigationItem.titleView = UIImageView.init(image:UIImage.init(named: "MainTitle"))
        
        navigationItem.leftBarButtonItem = Common.itemWithImage(UIImage.init(named: "MainTagSubIcon")!,highlightImage:UIImage.init(named: "MainTagSubIconClick")!, target: self, action: "tagView")
        view.backgroundColor = WBBgColor
        
    }
    
    
    
    
}
