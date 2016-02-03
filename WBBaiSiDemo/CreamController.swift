
//
//  CreamController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//  精华controller

import UIKit

class CreamController: UIViewController,UIScrollViewDelegate {
    
    /**  选中的的button  */
    var selectedBtn:UIButton?
    /**  titleView下边的红线  */
    let indicateLine = UIView.init()
    /**  contentView  */
    let contentView = UIScrollView.init()
    /**  contentView数量  */
    let contentCount = 5
    /**  titleView  */
    let titleView = UIView.init()
    /**  标签的id数组  */
    var contentIds:[TopicType] = [.All,.Video,.Picture,.Word,.Sound]
    /**  当前页面  */
    var currentPage:Int{
        return Int(contentView.contentOffset.x / view.frame.size.width)
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置naviBar
        setUpNaviBar()
        // 添加子控制器
        addChildViewControllers()
        // 添加scrollView容器
        setUpContentView()
        // 添加titleView
        setUpTitleView()
        
        
    }
    // MARK: - UIScrollView Delegate
    /**
    停止滚动动画的时候执行
    */
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let controller = childViewControllers[currentPage] as! TopicController
        controller.type = contentIds[currentPage].rawValue

        controller.view.frame = view.frame
        controller.view.frame.origin.x = scrollView.contentOffset.x

        contentView.addSubview(controller.view)
    }
    
    /**
     停止惯性的时候执行
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        didTouchTitleBtn(titleView.subviews[currentPage] as! UIButton)
        
    }
    
    
    // MARK: - event response
    
    //  打开 推荐标签 leftBarButtonItem
    func tagView(){
        navigationController?.pushViewController(RecommendTagController.init(), animated: true)
    }
    // 点击titleBtn
    func didTouchTitleBtn(sender: UIButton) {
        
        self.selectedBtn?.enabled = true
        self.selectedBtn = sender
        
        sender.enabled = false
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.indicateLine.frame.size.width = sender.titleLabel!.frame.width
            self.indicateLine.center.x = sender.center.x
        }

        contentView.setContentOffset(CGPoint(x: CGFloat(sender.tag) * view.frame.size.width, y: 0), animated: true)
        
    }
    
    // MARK: - private method
    
    /**
    添加所有子控制器
    */
    func addChildViewControllers() {
        for var i = 0; i < contentCount; i++ {
            addChildViewController(TopicController.init())
        }
    }
    /**
     设置scrollView的容器
     */
    func setUpContentView() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        contentView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        contentView.pagingEnabled = true
        contentView.contentSize = CGSize(width: view.frame.size.width * CGFloat( contentCount), height: view.frame.size.height)
        contentView.backgroundColor = WBBgColor
        contentView.showsHorizontalScrollIndicator = false
        contentView.delegate = self
        view.addSubview(contentView)
        
        
    }
    
    /**
     添加titleView
     */
    func setUpTitleView (){
        
        titleView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 35)
        titleView.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
        view.addSubview(titleView)
        
        indicateLine.frame = CGRect(x: 0, y: 33, width: 20, height: 2)
        indicateLine.backgroundColor = UIColor.redColor()
        
        let width = view.frame.width * 0.2
        let height = titleView.frame.height
        
        let array = ["全部","视频", "图片", "段子", "声音"]
        
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
                self.indicateLine.frame.size.width = button.titleLabel!.frame.width
                self.indicateLine.center.x = button.center.x
                
                scrollViewDidEndScrollingAnimation(contentView)
            }
            titleView.addSubview(indicateLine)
        }
        
    }
    
    /**
     设置naviBar
     */
    func setUpNaviBar() {
        
        navigationItem.titleView = UIImageView.init(image:UIImage.init(named: "MainTitle"))
        navigationItem.leftBarButtonItem = Common.itemWithImage(UIImage.init(named: "MainTagSubIcon")!,highlightImage:UIImage.init(named: "MainTagSubIconClick")!, target: self, action: "tagView")
        
    }
    
    
    
    
}
