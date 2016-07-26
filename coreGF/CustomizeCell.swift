//
//  CustomizeCell.swift
//  coreGF
//
//  Created by Quan on 7/26/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class CustomizeCell: UICollectionViewCell {
    let kCellWidth: CGFloat = 30
    var filteredImageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    func addSubviews() {
        if filteredImageView == nil {
            filteredImageView = UIImageView(frame: CGRect(x: 0, y: 10, width: kCellWidth, height: kCellWidth))
            filteredImageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(filteredImageView)
        }
    }
    
    override var selected: Bool {
        didSet{
            filteredImageView.layer.borderWidth = selected ? 2 : 0
        }
    }
}
