//
//  RecommdUserCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit
import Kingfisher

class RecommdUserCell: UITableViewCell {

    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var fanceLabel: UILabel!
    @IBOutlet private weak var attentionBtn: UIButton!
    
    var user:User?{
        didSet{
            
            self.nameLable.text = user!.screen_name
            self.fanceLabel.text = "\(user!.fans_count!)人关注"
            self.iconView.kf_setImageWithURL(NSURL.init(string: user!.header!)!, placeholderImage: UIImage.init(named: "defaultUserIcon"))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 为了显示白色边线 并且textLable居中
        textLabel?.frame.origin.y = 1
        textLabel?.frame.size.height = textLabel!.frame.height - 2
        
    }
    
    
}
