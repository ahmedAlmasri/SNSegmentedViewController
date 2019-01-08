//
//  SNSegmentTab.swift
//  Pods-SNSegmentedViewController_Example
//
//  Created by Ahmad AlMasri on 1/6/19.
//Copyright (c) 2019 ahmedAlmasri <ahmed.almasri@ymail.com>

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.


import Foundation
import UIKit

typealias DidSelectSegmentAtIndex = (_ segment: SNSegmentTab?,_ index: Int,_ animated: Bool) -> Void

open class SNSegmentTab: UIView {
    
    let kSegmentViewTagOffset = 100
    let button = UIButton(type: .custom)
    
    var didSelectSegmentAtIndex: DidSelectSegmentAtIndex?
    var isSelected = false {
        didSet {
            button.isSelected = isSelected
        }
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        setTitle(title)
    }
    
    convenience init(view: UIView) {
        self.init(frame: CGRect.zero)
        
        insertSubview(view, at: 0)
        view.removeConstraints(view.constraints)
        addConstraintsToView(view)
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        button.frame = bounds
        button.addTarget(self, action: #selector(self.onSegmentButtonPress(_:)),
                         for: .touchUpInside)
        addSubview(button)
        addConstraintsToView(button)
    }
    
    func addConstraintsToView(_ view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["view": view])
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["view": view])
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setTitle(_ title: String) {
        
        button.setTitle(title, for: .normal)
    }
    
    open func titleColor(_ color: UIColor) {
        
        button.setTitleColor(color, for: .normal)
    }
    
    open func selectedTitleColor(_ color: UIColor?) {
        
        button.setTitleColor(color, for: .selected)
    }
    
    open func titleFont(_ font: UIFont) {
        
        button.titleLabel?.font = font
    }
    
    @objc func onSegmentButtonPress(_ sender: AnyObject) {
        
        let index = tag - kSegmentViewTagOffset
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DidChangeSegmentIndex"),
                                        object: index)
        
        if didSelectSegmentAtIndex != nil {
            didSelectSegmentAtIndex!(self, index, true)
        }
    }
}
