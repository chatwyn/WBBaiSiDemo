//
//  WBTextView.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class WBTextView: UITextField {

    override func becomeFirstResponder() -> Bool {
        
        // 点击的时候 改变placeholder 为白色
        let attrs = [NSForegroundColorAttributeName:textColor as! AnyObject]
        let placeholder = NSAttributedString.init(string: self.placeholder!, attributes: attrs)
        attributedPlaceholder = placeholder
        

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        //退出的时候为灰色
        let attrs = [NSForegroundColorAttributeName:UIColor.grayColor() as AnyObject]
        let placeholder = NSAttributedString.init(string: self.placeholder!, attributes: attrs)
        attributedPlaceholder = placeholder
        
        return super.resignFirstResponder()
    }
    
}
