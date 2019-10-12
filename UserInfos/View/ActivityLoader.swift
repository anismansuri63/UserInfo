//
//  ActivityLoader.swift
//  Test
//
//  Created by ANIS MANSURI  on 22/06/19.
//  Copyright © 2019 ANIS MANSURI . All rights reserved.
//

import UIKit

class ActivityLoader: NSObject {

    // MARK: Shared Instance

    static let shared = ActivityLoader()

    // MARK: Init

    override init() {
        super.init()
        guard let window = UIApplication.shared.keyWindow else { return }

        container.frame = window.frame
        container.center = window.center
        container.backgroundColor = UIColor.clear

        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = window.center
        loadingView.backgroundColor = UIColor.appOrange
        loadingView.layer.cornerRadius = 10

        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
    }

    lazy var container: UIView = UIView()
    lazy var loadingView: UIView = UIView()
    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(container)
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.activityIndicator.startAnimating()
        }

        delay(35) { [weak self] in
            self?.hide()
        }
    }

    func hide() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.stopAnimating()
        }

        container.removeFromSuperview()
    }
}
