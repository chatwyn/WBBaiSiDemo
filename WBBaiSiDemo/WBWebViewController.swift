//
//  WBWebViewController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/2/2.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class WBWebViewController: UIViewController {

    var webView = UIWebView.init()

    var url:NSURLRequest?{
        didSet{
            self.webView.loadRequest(url!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        
    }
}
