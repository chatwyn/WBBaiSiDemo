//
//  RecommendController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import MJRefresh

class RecommendController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    /**  左侧目录tableView  */
    @IBOutlet weak var categoryTableView: UITableView!
    /**  右侧用户tableView  */
    @IBOutlet weak var userTableView: UITableView!
    /**  左侧标签列标  */
    var categories:[CategoryModel] = []
    /**  当前选中的目录  */
    var currentCategory:CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "推荐关注"  
        //    设置tableView
        setTableView()
        //    获得左侧列表
        gerCategories()
        
    }
    
    // MARK: - tableView DateSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView == categoryTableView{
            return categories.count
        }else{
            return currentCategory?.users.count ?? 0
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if tableView == categoryTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(CategoryCell).componentsSeparatedByString(".").last!) as! CategoryCell
            cell.category = categories[indexPath.row]            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(RecommdUserCell).componentsSeparatedByString(".").last!) as! RecommdUserCell
            cell.user = currentCategory?.users[indexPath.row]
            
            return cell
        }
    }
    
    // MARK: - tableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == categoryTableView{
            
            //  停止刷新  网络请求并没有停止
            let header =  self.userTableView.tableHeaderView as! MJRefreshNormalHeader
            header.endRefreshing()
            
            currentCategory = categories[indexPath.row]
            // 刷新tableView  保证 第一次加载时 不会显示刚刚的页面
            self.userTableView.reloadData()
            // 防止重新加载数据
            if (self.currentCategory!.users.isEmpty){
                    header.beginRefreshing()
            }
        }
    }
    
    // MARK: - private method
    // 获得左侧列表
    func gerCategories() {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.Black)

        AttentionTool.getCategory { (obj) -> () in
            
            self.categories = obj as! [CategoryModel]
            self.categoryTableView.reloadData()
            self.categoryTableView.selectRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
            self.tableView(self.categoryTableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: 0, inSection: 0))
            
        }
        
    }
    //设置tableView
    func setTableView() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        categoryTableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        userTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        categoryTableView.registerNib(UINib.init(nibName: NSStringFromClass(CategoryCell).componentsSeparatedByString(".").last!, bundle: nil), forCellReuseIdentifier: NSStringFromClass(CategoryCell).componentsSeparatedByString(".").last!)
        userTableView.registerNib(UINib.init(nibName: NSStringFromClass(RecommdUserCell).componentsSeparatedByString(".").last!, bundle: nil), forCellReuseIdentifier: NSStringFromClass(RecommdUserCell).componentsSeparatedByString(".").last!)
        
        userTableView.tableFooterView = UIView.init()
        userTableView.rowHeight = 70

        userTableView.tableHeaderView = MJRefreshNormalHeader.init(refreshingBlock: { () -> Void in
            let refreshCategory = self.currentCategory
            AttentionTool.getUsers(1, categoryId: (self.currentCategory?.id)!) { (obj) -> () in

                refreshCategory?.users = obj as! [User]
                //   防止因为网速慢 导致 显示内容错位 
                //  在闭包中，refreshCategory是局部变量，是值引用 不是址引用
                if refreshCategory != self.currentCategory!{
                    return
                }
                SVProgressHUD.dismiss()
                self.userTableView.reloadData()
                let a =  self.userTableView.tableHeaderView as! MJRefreshNormalHeader
                a .endRefreshing()
                
            }
            
        })
    }

    
    
    
}
