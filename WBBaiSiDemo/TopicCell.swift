//
//  TopicCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/23.
//  Copyright © 2016年 曹文博. All rights reserved.
//  首页的cell

import UIKit
import Kingfisher

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
    
    @IBOutlet weak var hotCommentView: UIView!
    @IBOutlet weak var hotCommentLabel: UILabel!
    /**  中间的图片  */
    let pictureView = TopicPictureView.pictureView()
    /**  音频  */
    let voiceView = TopicVoiceView.voiceView()
    /**  视频  */
    let videoView = TopicVideoView.videoView()
    

    
    class func topicCell() -> TopicCell{
        return NSBundle.mainBundle().loadNibNamed("TopicCell", owner: nil, options: nil)[0] as! TopicCell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bgView = UIImageView.init(image: UIImage.init(named: "mainCellBackground"))
        backgroundView = bgView
    }
    
    /**  Topic  */
    var topic:WBTopic?{
        didSet{
            
            self.iconView.kf_setImageWithURL(NSURL.init(string: topic!.profile_image)!, placeholderImage: UIImage.init(named: "defaultUserIcon"))
            
            
            self.isVipView.hidden = !(topic?.sina_v)!
            self.nameLabel.text = topic?.name
            self.creatTimeLabel.text = topic?.create_time
            self.text_label.text = topic?.text
            
            setBtnText(dingBtn, count: (topic?.ding)!, placeholder: "顶")
            setBtnText(commitBtn, count: (topic?.comment)!, placeholder: "评论")
            setBtnText(transmitBtn, count: (topic?.repost)!, placeholder: "转发")
            setBtnText(caiBtn, count: (topic?.cai)!, placeholder: "踩")
            
            // 处理cell中间的图片视频和音频
            if topic?.type == .Picture{
                if self.pictureView.superview == nil{
                    self.contentView.addSubview(pictureView)
                }
                self.pictureView.hidden = false
                self.pictureView.topic = topic
                self.pictureView.frame = topic!.pictureFrame
                
                self.voiceView.hidden = true
                self.videoView.hidden = true
            }else if topic?.type == .Sound{
                
                if self.voiceView.superview == nil{
                    self.contentView.addSubview(voiceView)
                }
                
                self.voiceView.hidden = false
                self.voiceView.topic = topic
                self.voiceView.frame = topic!.pictureFrame
                
                self.pictureView.hidden = true
                self.videoView.hidden = true
            }else if topic?.type == .Video{
                
                if self.videoView.superview == nil{
                    self.contentView.addSubview(videoView)
                }
                
                self.videoView.hidden = false
                self.videoView.topic = topic
                self.videoView.frame = topic!.pictureFrame
                
                self.pictureView.hidden = true
                self.voiceView.hidden = true
            }else{
                self.pictureView.hidden = true
                self.voiceView.hidden = true
                self.videoView.hidden = true
            }
            // 最热评论
            if let comment = topic!.top_cmt{
                self.hotCommentView.hidden = false
                let str = NSString.init(format: "%@:%@", comment.user!.username,comment.content) as String
                self.hotCommentLabel.text = str
            }else{
                self.hotCommentView.hidden = true
            }
            
            
        }
    }
    /**
     右上角的更多
     */
    @IBAction func more() {
        

        let actionSheet = UIActionSheet.init(title: nil, delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "收藏", "举报")
        actionSheet.showInView(self.window!)
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
    
    
    // MARK: - set frame
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
    

    
    
    
    
    
}
