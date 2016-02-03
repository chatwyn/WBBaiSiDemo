//
//  MeController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class MeController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBar()
        
        setTableView()
        
    }
    
    
    
    func setNaviBar () {
        // 设置导航栏标题
        navigationItem.title = "我的"
        
        navigationItem.rightBarButtonItems = [Common.itemWithImage(UIImage.init(named:"mine-setting-icon")!,highlightImage:UIImage.init(named: "mine-setting-icon-click")!, target: self, action: "tagView"),
            Common.itemWithImage(UIImage.init(named:"mine-moon-icon")!,highlightImage:UIImage.init(named: "mine-moon-icon-click")!, target: self, action: "tagView")]
        
        view.backgroundColor = WBBgColor
    }
    
    func tagView() {
        
    }
    
    func setTableView() {
        
        self.tableView.separatorStyle = .None
        
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = margin
        
        self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0)
        
        self.tableView.tableFooterView = MeFooterView.init(frame: CGRectZero, settingHeightAction: { () -> () in
            //            self.tableView.setn
        })
        
        
        
    }
    
    // MARK: - tableView Datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell.init()
        cell.selectionStyle = .None
        
        
        if (indexPath.section == 0) {
            cell.imageView?.image = UIImage.init(named: "mine-moon-icon-nearby")
            cell.textLabel!.text = "登录/注册"
        } else if (indexPath.section == 1) {
            cell.textLabel!.text = "离线下载"
        }
        
        return cell
        
        
    }
    
}