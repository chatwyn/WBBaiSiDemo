//
//  TopicPictureView.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/24.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import SDWebImage


class TopicPictureView: UIView {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gifMark: UIImageView!
    @IBOutlet weak var seeBigBtn: UIButton!
    @IBOutlet weak var progressView: DALabeledCircularProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .None
        self.progressView.progressLabel.textColor = UIColor.whiteColor()
        self.progressView.roundedCorners = 2
    }
    
    class func pictureView() -> TopicPictureView {
        return NSBundle.mainBundle().loadNibNamed("TopicPictureView", owner: nil, options: nil)[0] as! TopicPictureView
    }
    
    @IBAction func seeBigImage() {
        let pc = PictureController.init()
        pc.topic = self.topic
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(pc, animated: true, completion:nil)
        
        
    }
    
    /**
     给进度条设置进度
     */
    func setProgress() {
        self.progressView.hidden = false;
        self.progressView.setProgress(self.topic!.imageProgress, animated: false)
        let str = NSString(string: "\((Int(self.topic!.imageProgress * 100)))%");
        str.stringByReplacingOccurrencesOfString("-", withString: "")
        self.progressView.progressLabel.text = str as String
        
        // 当没下载完的时候 不能查看大图
        self.imageView.userInteractionEnabled = false
    }
    
    
    /**  话题  */
    var topic:WBTopic?{
        
        didSet{
            
            // 防止因为网速过慢导致 进度条不显示 和 进度条显示上一个的进度
            setProgress()
            
            self.imageView.sd_setImageWithURL(NSURL.init(string: (topic?.large_image)!), placeholderImage: nil, options: SDWebImageOptions(rawValue: 0),progress: { (receivedSize:Int, expectedSize:Int) -> Void in
                
                self.topic!.imageProgress = CGFloat(receivedSize)/CGFloat(expectedSize)
                
                self.setProgress()
                
                }) { (image:UIImage!, error:NSError!,cacheType:SDImageCacheType! , imageURL:NSURL!) -> Void in
                    self.progressView.hidden = true
                    self.imageView.userInteractionEnabled = true
                    
            }
            
            //是否gif动图
            self.gifMark.hidden = !topic!.large_image.hasSuffix("gif")
            // 是否是大图
            self.seeBigBtn.hidden = !topic!.isBigImage
            
        }
    }
    
    
    
    
}
