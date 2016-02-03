//
//  TopicPictureView.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/24.
//  Copyright © 2016年 曹文博. All rights reserved.
//  cell中间的图片

import UIKit
import Kingfisher


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
    
    // MARK: - event response
    @IBAction func seeBigImage() {
        let pc = PictureController.init()
        pc.topic = self.topic
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(pc, animated: true, completion:nil)
    }
    
    // MARK: - private method
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
            
            imageView.kf_setImageWithURL(NSURL.init(string: (topic?.large_image)!)!,
                placeholderImage: nil,
                optionsInfo: nil,
                progressBlock: { (receivedSize, totalSize) -> () in
                    self.topic!.imageProgress = CGFloat(receivedSize)/CGFloat(totalSize)
                    self.setProgress()
                },
                completionHandler: { (image, error, cacheType, imageURL) -> () in

                    if image != nil{                       
                        self.progressView.hidden = true
                        self.imageView.userInteractionEnabled = true
                        
                        if (self.topic?.isBigImage == false) {
                            return
                        }
                        
                        // 为了让大图的顶部显示到上边
                        UIGraphicsBeginImageContextWithOptions(self.topic!.pictureFrame.size, true, 0.0);
                        
                        let width = self.topic!.pictureFrame.size.width
                        let height = width * (image?.size.height)! / (image?.size.width)!
                        image?.drawInRect(CGRect(x: 0, y: 0, width: width, height: height))
                        
                        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                        
                        UIGraphicsEndImageContext();
                    }
                    
                }
            )
            
            
            
            //是否gif动图
            self.gifMark.hidden = !topic!.large_image.hasSuffix("gif")
            // 是否是大图
            self.seeBigBtn.hidden = !topic!.isBigImage
            
        }
    }
    
    
    
    
}
