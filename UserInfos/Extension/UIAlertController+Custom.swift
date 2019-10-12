//
//  UIAlertController+Custom.swift
//  CustomVideoPlayer
//
//  Created by ANIS MANSURI  on 21/06/19.
//  Copyright © 2019 ANIS MANSURI . All rights reserved.
//

import UIKit
enum AlertMesssage: String {
    case internetNotAvailable = "The Internet connection appears to be offline."
    case logout = "Are you sure, you wanto to logout?"
    case dataNotReadable = "Data is not readable."
    case somethingWentWrong = "Someting went wrong."
}
extension UIAlertController {
    
    static func showAlert(title: String? = Bundle.main.displayName,
                          message: AlertMesssage,
                          buttonTitles: [String] = ["Okay"],
                          completion: ((Int) -> Void)? = nil) {
        UIAlertController.showAlert(title: title, message: message.rawValue, buttonTitles: buttonTitles, completion: completion)

    }
    static func showAlert(title: String? = Bundle.main.displayName,
                          message: String,
                          buttonTitles: [String] = ["Okay"],
                          completion: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        for index in 0 ..< buttonTitles.count {
            let action = UIAlertAction(title: buttonTitles[index], style: .default) { _ in
                completion?(index)
            }
            alertController.addAction(action)
        }

        DispatchQueue.main.async {
            UIViewController.topMostViewController.present(alertController, animated: true, completion: nil)
        }
    }

}
extension UIViewController {
    static var topMostViewController: UIViewController {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
}
