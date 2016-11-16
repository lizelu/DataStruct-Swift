//
//  DisplayView.swift
//  AllKindsOfSortForiOS
//
//  Created by Mr.LuDashi on 16/11/16.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import UIKit

class DisplayView: UIView {
    var numberCount: Int = 1
    var displayViewHeight: CGFloat {
        get {
            return self.frame.height
        }
    }
    
    var displayViewWidth: CGFloat {
        get {
            return self.frame.width
        }
    }
    
    var lineWidth: CGFloat {
        get {
            return self.displayViewWidth / CGFloat(self.numberCount)
        }
    }
    
    var bezierPathArray: Array<UIBezierPath> = []
    var lineHeights: Array<Int> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updateLines(lineHeights: Array<Int>) {
        self.lineHeights = lineHeights
        self.bezierPathArray.removeAll()
        for i in 0..<self.lineHeights.count {
            let bezier = initBezierPath(index: i , lineHeight: lineHeights[i])
            self.bezierPathArray.append(bezier)
        }
        self.setNeedsDisplay()
    }
    
    func updateLine(index: Int, lineHeight: Int) {
        self.bezierPathArray[index] = self.initBezierPath(index: index, lineHeight: lineHeight)
        self.setNeedsDisplay()
    }

    private func initBezierPath(index: Int, lineHeight: Int) -> UIBezierPath {
        let bezier: UIBezierPath = UIBezierPath()
        let x = lineWidth * CGFloat(index) + lineWidth / 2
        bezier.move(to: CGPoint(x: x, y: displayViewHeight))
        
        let y = displayViewHeight - CGFloat(lineHeight)
        bezier.addLine(to: CGPoint(x: x, y: y))
        return bezier
    }
    
    func clearView()  {
        for item in self.bezierPathArray {
            item.removeAllPoints()
        }
        self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for i in 0..<self.bezierPathArray.count {
            let weight = CGFloat(self.lineHeights[i]) / displayViewHeight
            let color = UIColor(hue: weight, saturation: 1, brightness: 1, alpha: 1)
            color.setStroke()
            let bezierPath: UIBezierPath = self.bezierPathArray[i]
            bezierPath.lineWidth = self.lineWidth
            bezierPath.stroke()
        }
    }

}
