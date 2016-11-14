//
//  SortView.swift
//  AllKindsOfSortForiOS
//
//  Created by Mr.LuDashi on 16/11/14.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import UIKit

class SortView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        let y: CGFloat = (self.superview?.frame.height)! - frame.height
        self.frame = frame
        self.frame.origin.y = y
    }
    
    func updateHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
