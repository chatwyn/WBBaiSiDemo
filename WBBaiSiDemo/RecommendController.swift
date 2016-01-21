//
//  RecommendController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

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
        view.backgroundColor = WBBgColor
        
        
        categoryTableView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        userTableView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)

        categoryTableView.registerNib(UINib.init(nibName: NSStringFromClass(CategoryCell).componentsSeparatedByString(".").last!, bundle: nil), forCellReuseIdentifier: NSStringFromClass(CategoryCell).componentsSeparatedByString(".").last!)
        
        userTableView.registerNib(UINib.init(nibName: NSStringFromClass(RecommdUserCell).componentsSeparatedByString(".").last!, bundle: nil), forCellReuseIdentifier: NSStringFromClass(RecommdUserCell).componentsSeparatedByString(".").last!)
        
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
            let cell = UITableViewCell.init()
            return cell
        }
    }
    
    // MARK: - tableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentCategory = categories[indexPath.row]
        
        print(currentCategory?.id)
        
        AttentionTool.getUsers(1, categoryId: (currentCategory?.id)!) { (obj) -> () in
            
        }
        
    }
    
    // MARK: - private method
    // 获得左侧列表
    func gerCategories() {
        
        AttentionTool.getCategory { (obj) -> () in
            
            self.categories = obj as! [CategoryModel]
            self.categoryTableView.reloadData()
            self.categoryTableView.selectRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
            
        }
        
    }
    
    
    
    
}
