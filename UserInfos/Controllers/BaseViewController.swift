//
//  BaseViewController.swift
//  CustomVideoPlayer
//
//  Created by ANIS MANSURI  on 22/06/19.
//  Copyright © 2019 ANIS MANSURI . All rights reserved.
//

import UIKit
// MARK: TTLeftBarButtonType
enum BarButtonType: Int {
    case
    backArrow, logout, reload, none
    
    var imageName: String {
        switch self {
        case .backArrow:
            return "back"
        case .logout:
            return "logout"
        case .reload:
            return "reload"
        case .none:
            return ""
        }
    }
}

class BaseViewController: UIViewController {
    // MARK: - Variables
    /// Override this method to `backButtonTapHandler` use in current view controller.
    
    var backButtonType: BarButtonType = BarButtonType.none {
        didSet {
            // Left Item Button
            if self.backButtonType == .none {
                self.navigationItem.hidesBackButton = true
            } else {
                let buttonLeftBar = UIButton(type: .custom)
                buttonLeftBar.isExclusiveTouch = true
                buttonLeftBar.frame = CGRect(x: -15, y: 0, width: 30, height: 30)
                buttonLeftBar.setImage(UIImage(named: self.backButtonType.imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
                buttonLeftBar.imageView?.tintColor = UIColor.appOrange
                buttonLeftBar.addTarget(self, action: #selector(self.backButtonTapHandler(sender:)), for: .touchUpInside)
                let item = UIBarButtonItem(customView: buttonLeftBar)
                self.navigationItem.leftBarButtonItem = item
            }
        }
    }
    /// Override this method to `rightBarButtonClicked` use in current view controller.
    var rightBarButtonType: BarButtonType = BarButtonType.none {
        didSet {
            if self.rightBarButtonType != .none {
                let buttonRightBar = UIButton(type: .custom)
                buttonRightBar.isExclusiveTouch = true
                
                buttonRightBar.frame = CGRect(x: -15, y: 0, width: 30, height: 30)
                buttonRightBar.setImage(UIImage(named: self.rightBarButtonType.imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
                
                buttonRightBar.addTarget(self, action: #selector(self.rightBarButtonClicked(sender:)), for: .touchUpInside)
                buttonRightBar.imageView?.tintColor = UIColor.appOrange
                let item = UIBarButtonItem(customView: buttonRightBar)
                self.navigationItem.rightBarButtonItem = item
            }
        }
    }
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    func setup() {
        

    }
    
    @objc func backButtonTapHandler(sender: UIButton) {
        switch self.backButtonType {
        case .backArrow:
            _ = self.navigationController?.popViewController(animated: true)
            
        default: break
        }
    }
    @objc func rightBarButtonClicked(sender: UIBarButtonItem) {
        
    }
}
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController?.viewControllers.count ?? 0 > 1

    }
}
