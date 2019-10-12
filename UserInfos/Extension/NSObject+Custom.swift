//
//  NSObject+Custom.swift
//  CustomVideoPlayer
//
//  Created by ANIS MANSURI  on 21/06/19.
//  Copyright © 2019 ANIS MANSURI . All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
    
    static var nibName: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}
extension Bundle {
    var displayName: String {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }
}
extension UIApplication {
    func setRootViewController(viewController: UIViewController, isNavigationBarNeeded: Bool = true) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if isNavigationBarNeeded {
            let navbar = UINavigationController(rootViewController: viewController)
            window.rootViewController = navbar
        } else {
            window.rootViewController = viewController
        }
    }
}

extension UIColor {
    static var appOrange: UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 102/255, alpha: 1)
    }
    static var appGreen: UIColor {
        return UIColor(red: 0/255, green: 194/255, blue: 104/255, alpha: 1)
    }
    static var appBlue: UIColor {
        return UIColor(red: 0/255, green: 131/255, blue: 186/255, alpha: 1)
    }
    
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return ((self) ?? "").isEmpty
    }
    var value: String {
        return (self ?? "")
    }
}
