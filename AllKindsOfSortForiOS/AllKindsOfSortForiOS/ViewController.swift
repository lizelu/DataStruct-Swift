//
//  ViewController.swift
//  AllKindsOfSortForiOS
//
//  Created by Mr.LuDashi on 16/11/14.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var displayView: UIView!
    @IBOutlet var numberCountTextField: UITextField!
    @IBOutlet var modeMaskView: UIView!
    
    var sortViews: Array<SortView> = []
    var sortViewHight: Array<Int> = []
    var sort: SortType! = BubbleSort()
    
    var numberCount: Int = 200
    var displayViewHeight: CGFloat {
        get {
            return displayView.frame.height
        }
    }
    
    var displayViewWidth: CGFloat {
        get {
            return displayView.frame.width
        }
    }
    
    var sortViewWidth: CGFloat {
        get {
            return self.displayViewWidth / CGFloat(self.numberCount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSortClosure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.numberCountTextField.delegate = self
        self.numberCountTextField.text = "\(numberCount)"
        if sortViews.isEmpty {
            self.configSortViewHeight()
            self.addSortViews()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Response Event
    @IBAction func tapSegmentContol(_ sender: UISegmentedControl) {
        self.configSortViewHeight()
        for i in 0..<self.sortViews.count {
            self.updateSortViewHeight(index: i, value: CGFloat(sortViewHight[i]))
        }
        
        let sortType = SortTypeEnum(rawValue: sender.selectedSegmentIndex)!
        self.sort = SortFactory.create(type: sortType)
        self.setSortClosure()
    }
    
    @IBAction func tapSortButton(_ sender: AnyObject) {
        self.modeMaskView.isHidden = false
        DispatchQueue.global().async {
            self.sortViewHight = self.sort.sort(items: self.sortViewHight)
        }
    }
    
    //MARK: -- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text
        guard let number: Int = Int(text!) else {
            return true
        }
        numberCount = number
        self.resetSubViews()
        return true
    }


    //MARK: - Private Method
    /// 设置排序对象相关的回调
    private func setSortClosure() {
        weak var weak_self = self
        sort.setEveryStepClosure(everyStepClosure: { (index, value) in
            DispatchQueue.main.async {
                weak_self?.updateSortViewHeight(index: index, value: CGFloat(value))
            }
        }) { (list) in
            DispatchQueue.main.async {
                weak_self?.modeMaskView.isHidden = true
            }
        }
    }
    
    /// 随机生成sortView的高度
    private func configSortViewHeight() {
        if !sortViewHight.isEmpty {
            sortViewHight.removeAll()
        }
        for _ in 0..<self.numberCount {
            self.sortViewHight.append(Int(arc4random_uniform(UInt32(displayViewHeight))))
        }
    }
    
    private func addSortViews() {
        for i in 0..<self.numberCount {
            let size: CGSize = CGSize(width: self.sortViewWidth, height: CGFloat(sortViewHight[i]))
            let origin: CGPoint = CGPoint(x: CGFloat(i) * sortViewWidth, y: 0)
            let sortView = SortView(frame: CGRect(origin: origin, size: size))
            self.displayView.addSubview(sortView)
            self.sortViews.append(sortView)
        }
    }
    
    private func updateSortViewHeight(index: Int, value: CGFloat) {
        self.sortViews[index].updateHeight(height: value)
    }
    
    private func resetSubViews()  {
        for subView in self.sortViews  {
            subView.removeFromSuperview()
        }
        self.sortViews.removeAll()
        self.sortViewHight.removeAll()
        self.configSortViewHeight()
        self.addSortViews()
    }
    
}

