//
//  ViewController.swift
//  SNSegmentedViewController
//
//  Created by ahmedAlmasri on 01/06/2019.
//  Copyright (c) 2019 ahmedAlmasri. All rights reserved.
//

import UIKit
import SNSegmentedViewController

class ParentViewController: SNSegmentedViewController {

     var selectedSegment: SNSegmentTab?
    
    override func viewDidLoad() {
        setupTabs()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  private func setupTabs() {

     let tabOneVC = TabOneController()
    tabOneVC.title = "Tab One"
    let tabTwoVC = TabTwoController()
     tabTwoVC.title = "Tab Two"

       segmentControllers = [tabOneVC, tabTwoVC]
      //  headerViewHeight = 120
        selectedSegmentViewHeight = 2.0
        segmentTitleColor = .gray
        segmentSelectedTitleColor = .blue
        selectedSegmentViewColor = .blue
        segmentViewHeight = 44
        segmentTitleFont = .boldSystemFont(ofSize: 14)
        //segmentShadow = SNShadow.light()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
    }
}

extension ParentViewController: SNSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SNSegmentTab?, index: Int) {
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)
        }
    }
}
