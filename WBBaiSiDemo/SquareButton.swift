//
//  SquareButton.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/2/2.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class SquareButton: UIButton {
    
    /**  square  */
    var square:Square?{
        didSet{
            self.setTitle(square!.name, forState: .Normal)
            self.kf_setImageWithURL(NSURL.init(string: (square?.icon)!)!, forState: .Normal)

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.titleLabel!.textAlignment = .Center
        self.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.setBackgroundImage(UIImage.init(named: "mainCellBackground"), forState: .Normal)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片
        self.imageView!.y = self.height * 0.15;
        self.imageView!.width = self.width * 0.5;
        self.imageView!.height = self.imageView!.width;
        self.imageView!.centerX = self.width * 0.5;
        
        // 调整文字
        self.titleLabel!.x = 0;
        self.titleLabel!.y = CGRectGetMaxY(self.imageView!.frame);
        self.titleLabel!.width = self.width;
        self.titleLabel!.height = self.height - self.titleLabel!.y;
        
    }
    
    
}
