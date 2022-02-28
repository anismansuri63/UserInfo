//
//  FIle.swift
//  UserInfo
//
//  Created by Anis Mansuri on 12/10/19.
//  Copyright © 2019 Anis Mansuri. All rights reserved.
//

import Foundation
func delay(_ delay: Double, closure: @escaping () -> Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}
