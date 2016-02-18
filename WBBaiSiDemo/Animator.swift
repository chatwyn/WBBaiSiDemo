//
//  Animator.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/2/18.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class Animater:NSObject,UIViewControllerAnimatedTransitioning {
    
    private var toView:UIView?
    private var transitionContext:UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        self.transitionContext = transitionContext
        return 1.0
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        let fromController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let containerView = transitionContext.containerView()
        
        let fromView = fromController?.view
        let toView = toController?.view
        
        self.toView = toView
        containerView?.addSubview(toView!)
        
        toView?.frame = fromView!.frame
        
        let path = UIBezierPath.init(ovalInRect: CGRect(x: toView!.centerX - 20, y: toView!.centerY - 20, width:40 , height: 40))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath.init(rect: toView!.frame).CGPath
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.delegate = self
        animation.duration = transitionDuration(transitionContext)
        animation.fromValue = path.CGPath
        animation.toValue = UIBezierPath.init(rect: toView!.frame).CGPath
        
        maskLayer.addAnimation(animation, forKey: "mask")
        
        toView?.layer.mask = maskLayer
        


        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.transitionContext?.completeTransition(true)
        toView?.layer.mask = nil
        
    }
}