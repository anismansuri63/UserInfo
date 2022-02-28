//
//  File.swift
//  Detail
//
//  Created by stl-035 on 09/08/19.
//  Copyright © 2019 ANIS MANSURI . All rights reserved.
//

import UIKit
extension UIView {
    func addBorder(width: CGFloat = 1, color: UIColor = .gray) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
