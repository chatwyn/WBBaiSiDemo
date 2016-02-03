//
//  RecommendTagCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/22.
//  Copyright © 2016年 曹文博. All rights reserved.
//  推荐关注里的cell

import UIKit
import Kingfisher

class RecommendTagCell: UITableViewCell {
    
    @IBOutlet weak var fanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    /**  标签内容  */
    var recommendTag:RecommendTag?{
        didSet{
            
            if (recommendTag!.sub_number?.integerValue  < 10000) {
                self.fanceLabel.text = "\(recommendTag!.sub_number!)人订阅"
            } else { // 大于等于10000
                self.fanceLabel.text = "\((Int((recommendTag?.sub_number?.doubleValue)!)) / 10000)万人订阅"
            }
            
            self.nameLabel.text = recommendTag?.theme_name
            
            self.iconView.kf_setImageWithURL(NSURL.init(string: (recommendTag?.image_list)!)!, placeholderImage: UIImage.init(named: "defaultUserIcon"))
            
            
        }
    }
    
    @IBAction func attention() {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
