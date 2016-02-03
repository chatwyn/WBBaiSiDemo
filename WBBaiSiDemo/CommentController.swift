//
//  CommentController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/31.
//  Copyright © 2016年 曹文博. All rights reserved.
//  评论页面

import UIKit
import MJRefresh

class CommentController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    /**  顶部的topic  */
    var topic:WBTopic?
    /**  评论当前页  */
    var page = 0
    /**  当前正在请求的参数  */
    var params = NSMutableDictionary()
    /**  header  */
    var header:MJRefreshNormalHeader{
        return (self.tableView.tableHeaderView as? MJRefreshNormalHeader)!
    }
    /**  footer  */
    var footer:MJRefreshFooter{
        return (self.tableView.tableFooterView as? MJRefreshFooter)!
    }
    /**  最热评论  */
    var hotComments:[Comment] = []
    /**  最新评论  */
    var latestComments:[Comment] = []
    
    // MARK: -  life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        
        setUptableView()
        
    }
    
    // MARK: - tableView dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.hotComments.count > 0{
            return 3
        } else if self.latestComments.count > 0{
            return 2
        } else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }else if section == 1{
            return self.hotComments.count > 0 ? self.hotComments.count : self.latestComments.count
        }else{
            return self.latestComments.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if indexPath.section == 0 {
            let cell =  TopicCell.topicCell()
            cell.topic = self.topic
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(String(CommentCell)) as! CommentCell
            
            cell.comment = getComments(indexPath)
            return cell
        }
    }
    
    func getComments(indexPath:NSIndexPath) -> Comment{
        
        var comment:Comment?
        
        if indexPath.section == 1{
            comment = hotComments.count > 0 ? hotComments[indexPath.row] : latestComments[indexPath.row]
        }else{
            comment = latestComments[indexPath.row]
        }
        return comment!
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return self.hotComments.count > 0 ? "最热评论" : "最新评论"
        }else if section == 2{
            return "最新评论"
        }else{
            return nil
        }
    }
    // MARK: - tableView Delegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return topic!.cellHeight
        }else {
            return getComments(indexPath).cellHeight
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    // MARK: - private method
    func setTitle(){
        
        self.title = "评论";
        self.navigationItem.rightBarButtonItem = Common.itemWithImage(UIImage.init(named:"comment_nav_item_share_icon")!, highlightImage:UIImage.init(named:"comment_nav_item_share_icon_click")! , target: self, action: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        self.tableView.backgroundColor = WBBgColor
        self.tableView.registerNib(UINib.init(nibName: String(CommentCell), bundle: nil), forCellReuseIdentifier: String(CommentCell))
    }
    
    func setUptableView() {
        
        tableView.contentInset = UIEdgeInsets(top: -54, left: 0, bottom: 0, right: 0)
        tableView.tableHeaderView = MJRefreshNormalHeader.init(refreshingBlock: { () -> Void in
            // 结束下拉刷新
            //            self.footer.endRefreshing()
            var params = [String:AnyObject]()
            params["a"] = "dataList";
            params["c"] = "comment";
            params["data_id"] = self.topic!.id
            params["hot"] = 1
            
            self.params.setDictionary(params);
            // 发送请求
            CreamTool.getComments(params, successfulBlock: { (obj) -> () in
                // 返回的结果 不是最新一次的结果 不处理
                if (!self.params.isEqualToDictionary(params)){
                    return
                }
                
                self.hotComments = obj[0] as! [Comment]
                self.latestComments = obj[1] as! [Comment]
                let count = obj[2] as! Int
                
                if self.latestComments.count >= count{
                }
                
                self.tableView.reloadData()
                self.header.endRefreshing()
            })
        })
        
        self.header.automaticallyChangeAlpha = true
        self.header.beginRefreshing()
    }
    /**
     键盘通知
     
     - parameter noti: 通知
     */
    func keyboardWillChangeFrame(noti:NSNotification) {
        
        let frame = noti.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        self.bottomConstant.constant = screenH - frame.origin.y
        
        let duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
}
