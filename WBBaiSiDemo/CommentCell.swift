//
//  CommentCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/2/1.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import Kingfisher

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var zanPeopleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let bgView = UIImageView.init()
        bgView.image = UIImage.init(named: "mainCellBackground");
        self.backgroundView = bgView;
    }
    
    var comment:Comment?{
        didSet{
            self.iconView.kf_setImageWithURL(NSURL.init(string: (comment?.user?.profile_image)!)!,placeholderImage: UIImage.init(named: "defaultUserIcon")!)
            
            self.contentLabel.text = comment?.content
            self.nameLabel.text = comment?.user?.username
            self.zanPeopleLabel.text = "\(comment!.like_count)"
            
            if (!comment!.voiceuri.isEmpty){
                self.voiceBtn.hidden = false
                self.voiceBtn.setTitle(NSString.init(format: "%d''",comment!.like_count) as String, forState: .Normal)
            }else{
                self.voiceBtn.hidden = true
            }
            
        }
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
            
            oldFrame = newFrame
    
            super.frame = newFrame
        }
    }
    
}



