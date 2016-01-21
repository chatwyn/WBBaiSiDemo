//
//  CategoryCell.swift
//  WBBaiSiDemo
//
//  Created by caowenbo on 16/1/21.
//  Copyright © 2016年 曹文博. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var selectedIndicator: UIView!
    
    var category:CategoryModel?{
        didSet{
            textLabel?.text = category?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clearColor()
        
        self.selectedIndicator.backgroundColor = UIColor(red: 219/255, green: 21/255, blue: 26/255, alpha: 1)

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 为了显示白色边线 并且textLable居中
        textLabel?.frame.origin.y = 1
        textLabel?.frame.size.height = textLabel!.frame.height - 2
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedIndicator.hidden = !selected
        textLabel?.textColor = selected ? self.selectedIndicator.backgroundColor :UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 1)
    }
    
}
