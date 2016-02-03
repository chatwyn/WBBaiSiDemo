//
//  PublishController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/25.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class PublishController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var slogsanView: UIImageView!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.userInteractionEnabled = false
        // Do any additional setup after loading the view.
        self.containerView.transform = CGAffineTransformMakeTranslation(0, -500)
        self.slogsanView.transform = CGAffineTransformMakeTranslation(200, -200)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animateWithDuration(0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 10,
            options: .CurveEaseInOut,
            animations: { () -> Void in
            self.containerView.transform = CGAffineTransformIdentity
            self.slogsanView.transform = CGAffineTransformIdentity
            
            }) { (bool:Bool) -> Void in
                self.view.userInteractionEnabled = true
        }
    }
    
    // MARK: - event response
    @IBAction func cancel() {
        
        self.view.userInteractionEnabled = false
        
        self.containerView.transform = CGAffineTransformIdentity
        self.slogsanView.transform = CGAffineTransformIdentity
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.containerView.transform = CGAffineTransformMakeTranslation(0, 500)
            self.slogsanView.transform = CGAffineTransformMakeTranslation(0, 700)
            }) { (bool:Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
        }
        
        
        
    }
    
    
    
}
