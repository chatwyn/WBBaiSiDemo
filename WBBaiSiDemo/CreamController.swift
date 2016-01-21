//
//  CreamController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CreamController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        navigationItem.titleView = UIImageView.init(image:UIImage.init(named: "MainTitle"))

        navigationItem.leftBarButtonItem = Common.itemWithImage(UIImage.init(named: "MainTagSubIcon")!,highlightImage:UIImage.init(named: "MainTagSubIconClick")!, target: self, action: "tagView")
                view.backgroundColor = WBBgColor
        
    }
    
    func tagView(){
        navigationController?.pushViewController(UIViewController.init(), animated: true)
    }


}
