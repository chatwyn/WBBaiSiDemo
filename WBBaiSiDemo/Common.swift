//
//  Common.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/20.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

public let WBBgColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)

//cell中text的Y值
let topicCellTextY:CGFloat = 55
//cell  的间距
let margin:CGFloat = 10
//cell 底部按钮的高度
let cellBottomBtnH:CGFloat = 35
//cell 最热评论的高度
let hotCommentTitleH:CGFloat = 20
// 图片的最大高度
let cellPictureMaxImageH:CGFloat = 1000
// 超过最大高度时候 设置的高度
let cellPictureModifiedH:CGFloat = 250
// 屏幕宽度
let screenW = UIScreen.mainScreen().bounds.width
// 屏幕高度
let screenH = UIScreen.mainScreen().bounds.height

extension UIView{
    var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    var centerX:CGFloat{
        get{
            return self.frame.midX
        }
        set{
            self.frame.origin.x = newValue - self.frame.size.width * 0.5
        }
    }
    
    var centerY:CGFloat{
        get{
            return self.frame.midY
        }
        set{
            self.frame.origin.y = newValue - self.frame.size.height * 0.5
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    
    var size:CGSize{
        get{
            return self.frame.size
        }
        set{
            self.frame.size = newValue
        }
    }
    
    func isShowingOnKeyWindow() -> Bool{
        let window = UIApplication.sharedApplication().keyWindow
        
        let newFrame = self.superview!.convertRect(self.frame, toView: window)
        let intersects = CGRectIntersectsRect(newFrame, (window?.frame)!)
        
        return !self.hidden && self.alpha > 0.01 && intersects
    }

}

class Common:NSObject{
    /**
     创建一个barButtonItem
     */
   class func itemWithImage(image:UIImage,highlightImage:UIImage,target:UIViewController,action:Selector) -> UIBarButtonItem{
    
        let button = UIButton.init()
    
        button.setBackgroundImage(image, forState: .Normal)
        button.setBackgroundImage(highlightImage, forState: .Highlighted)
    
        button.sizeToFit()
    
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        return UIBarButtonItem.init(customView: button)
        
    }
    
}

