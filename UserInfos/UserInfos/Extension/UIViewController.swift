//
//  UIViewController.swift
//  New App
//
//  Created by ANIS MANSURI  on 01/04/18.
//  Copyright © 2018 ANIS MANSURI . All rights reserved.
//

import UIKit

extension UIViewController {
    class func loadController() -> Self {
        return instantiateViewControllerFromMainStoryBoard()
    }

    private class func instantiateViewControllerFromMainStoryBoard<T>() -> T {
        let controller = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: String(describing: self)) as! T

        return controller
    }
}

extension UIStoryboard {
    class func mainStoryBoard(name: String = "Main") -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
