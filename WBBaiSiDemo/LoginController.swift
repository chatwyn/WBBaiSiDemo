//
//  LoginController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginLeftConstraint: NSLayoutConstraint!
    
    // MARK: - event response
    @IBAction func switchPage(sender: UIButton) {
        
        sender.selected = !sender.selected
        self.loginLeftConstraint.constant = sender.selected ? -view.frame.width : 0
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
        self.view.endEditing(true)
        
    }
    
    @IBAction func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
