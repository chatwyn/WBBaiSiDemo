//
//  TopicCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/23.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import SDWebImage

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var isVipView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creatTimeLabel: UILabel!
    @IBOutlet weak var dingBtn: UIButton!
    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet weak var transmitBtn: UIButton!
    @IBOutlet weak var caiBtn: UIButton!
    @IBOutlet weak var text_label: UILabel!
    
    /**  中间的图片  */
    var pictureView = TopicPictureView.pictureView()
    
    
    /**  Topic  */
    var topic:WBTopic?{
        didSet{
            
            self.iconView.sd_setImageWithURL(NSURL.init(string: (topic?.profile_image)!), placeholderImage: UIImage.init(named: "defaultUserIcon"))
            
            self.isVipView.hidden = !(topic?.sina_v)!
            self.nameLabel.text = topic?.name
            self.creatTimeLabel.text = topic?.create_time
            self.text_label.text = topic?.text
            
            setBtnText(dingBtn, count: (topic?.ding)!, placeholder: "顶")
            setBtnText(commitBtn, count: (topic?.comment)!, placeholder: "评论")
            setBtnText(transmitBtn, count: (topic?.repost)!, placeholder: "转发")
            setBtnText(caiBtn, count: (topic?.cai)!, placeholder: "踩")
            
            
            if topic?.type == .Picture{
                self.contentView.addSubview(self.pictureView)
                self.pictureView.topic = topic
                self.pictureView.frame = topic!.pictureFrame
            }else{
                self.pictureView.removeFromSuperview()
            }
            
        }
    }
    
    var oldFrame:CGRect?
    
    override var frame:CGRect{
        get {
            return super.frame
        }
        set {
            //  防止 重复减少
            if oldFrame == frame {
                return
            }
            // 让cell的上左右 有间距
            var newFrame = frame
            newFrame.origin.x = margin / 2
            newFrame.size.width -= margin
            newFrame.origin.y += margin
            newFrame.size.height -= margin
            
            oldFrame = newFrame
            
            super.frame = newFrame
        }
    }
    /**
     给button设置titie
     
     - parameter button:      button
     - parameter count:       设置的count
     - parameter placeholder: 如果没有数量时显示的文字
     */
    func setBtnText(button:UIButton,count:Int,var placeholder:String) {
        
        if count > 10000{
            placeholder = "\(count / 10000)"
        }else if count > 0{
            placeholder = "\(count)"
        }
        //没有的时候 就显示 文字
        button.setTitle(placeholder, forState: .Normal)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIImageView.init(image: UIImage.init(named: "mainCellBackground"))
        backgroundView = bgView
        
        self.autoresizingMask = .None
        
        
    }
    
    
    
    
}
