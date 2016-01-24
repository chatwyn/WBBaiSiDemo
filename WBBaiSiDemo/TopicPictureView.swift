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
    
    /**  话题  */
    var topic:WBTopic?{
        didSet{
            self.imageView.sd_setImageWithURL(NSURL.init(string: (topic?.large_image)!))

            self.gifMark.hidden = !topic!.large_image.hasSuffix("gif")
            self.seeBigBtn.hidden = !topic!.isBigImage
            
        }
    }
    
    class func pictureView() -> TopicPictureView {
        return NSBundle.mainBundle().loadNibNamed("TopicPictureView", owner: nil, options: nil)[0] as! TopicPictureView
    }
    
    @IBAction func seeBigImage() {
        
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
        self.autoresizingMask = .None
    }
}
