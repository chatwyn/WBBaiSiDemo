//
//  LoginController.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class LoginController: UIViewController,UITextFieldDelegate {
    
    let lineWidth:CGFloat = 103
    
    @IBOutlet weak var phoneLabel: WBTextView!
    @IBOutlet weak var txLogin: UIButton!
    @IBOutlet weak var sinaLogin: UIButton!
    @IBOutlet weak var XXbtn: UIButton!
    @IBOutlet weak var qqLogin: UIButton!
    @IBOutlet weak var letLineWidth: NSLayoutConstraint!
    @IBOutlet weak var rightLineWidth: NSLayoutConstraint!
    @IBOutlet weak var textlabel: UIView!
    
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var loginLeftConstraint: NSLayoutConstraint!
    
    let loginMaskLayer = CAShapeLayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
        self.qqLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
        self.sinaLogin.transform = CGAffineTransformMakeScale(0.01, 0.01)
        self.XXbtn.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
        
        self.textlabel.transform = CGAffineTransformMakeTranslation(375, 0)
        self.registBtn.transform = CGAffineTransformMakeTranslation(0, -100)
        self.letLineWidth.constant = 0
        self.rightLineWidth.constant = 0
        
        self.forgetBtn.layer.mask = CALayer.init()
        self.loginLabel.layer.mask = CALayer.init()
        
        self.loginBtn.layer.mask = loginMaskLayer
        loginMaskLayer.fillColor = UIColor.whiteColor().CGColor
        loginMaskLayer.path = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: 0, height: CGRectGetHeight(self.loginBtn.frame))).CGPath
        
        self.phoneLabel.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "a", name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 登陆框
        UIView.animateWithDuration(1.0) { () -> Void in
            self.textlabel.transform = CGAffineTransformIdentity
            self.registBtn.transform = CGAffineTransformIdentity
            self.XXbtn.transform = CGAffineTransformIdentity
            
        }
        
        // 忘记密码
        let beginPath = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: 0, height: CGRectGetHeight(self.forgetBtn.frame))).CGPath
        let endPath = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.forgetBtn.frame), height: CGRectGetHeight(self.forgetBtn.frame))).CGPath
        
        let forgetMask = CAShapeLayer.init()
        forgetMask.path = endPath
        forgetMask.fillColor = UIColor.whiteColor().CGColor
        self.forgetBtn.layer.mask = forgetMask
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.duration = 1.0
        animation.beginTime = CACurrentMediaTime()
        animation.fromValue = beginPath
        animation.toValue = endPath
        forgetMask.addAnimation(animation, forKey: "path")
        
        // 快速登录
        let startPath = UIBezierPath.init(rect: CGRect(x: self.loginLabel.width / 2 , y: 0, width: 0, height: CGRectGetHeight(self.loginLabel.frame))).CGPath
        let lastPath = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.loginLabel.frame), height: CGRectGetHeight(self.loginLabel.frame))).CGPath
        
        let loginMask = CAShapeLayer.init()
        loginMask.path = endPath
        loginMask.fillColor = UIColor.whiteColor().CGColor
        self.loginLabel.layer.mask = loginMask
        
        let loginAnimation = CABasicAnimation.init(keyPath: "path")
        loginAnimation.duration = 0.5
        loginAnimation.beginTime = CACurrentMediaTime()
        loginAnimation.fromValue = startPath
        loginAnimation.toValue = lastPath
        loginMask.addAnimation(loginAnimation, forKey: "path")
        
        self.letLineWidth.constant = lineWidth
        self.rightLineWidth.constant = lineWidth
        
        UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveLinear, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (finished:Bool) -> Void in
                
                UIView.animateWithDuration(1,
                    delay: 0.0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 10,
                    options: .CurveLinear, animations: { () -> Void in
                        self.txLogin.transform = CGAffineTransformIdentity
                        self.qqLogin.transform = CGAffineTransformIdentity
                        self.sinaLogin.transform = CGAffineTransformIdentity
                    }) { (finished:Bool) -> Void in
                        
                }
        }
        
        
    }

    // MARK: -  textfiled delegate
    func a() {
        let endPath = UIBezierPath.init(rect: CGRect(x: 0, y: 0, width:  CGRectGetWidth(self.loginBtn.frame) / 11 * (CGFloat((self.phoneLabel.text?.characters.count)!)), height: CGRectGetHeight(self.loginBtn.frame))).CGPath
        
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.duration = 0.2
        animation.beginTime = CACurrentMediaTime()
        animation.fromValue = loginMaskLayer.path
        animation.toValue = endPath
        loginMaskLayer.addAnimation(animation, forKey: "path")
        
        loginMaskLayer.path = endPath
    }
    
    
    
    
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
