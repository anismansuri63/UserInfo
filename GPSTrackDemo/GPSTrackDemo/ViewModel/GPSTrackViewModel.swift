//
//  GPSTrackViewModel.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import Foundation
import UIKit

class GPSTrackViewModel: NSObject {
    private var deviceInfo:RBDevices
    
    init(withDevices devices:RBDevices){
        self.deviceInfo = devices
        super.init()
    }
    
    // Add your display logic here
    func getName() -> String{
        return self.deviceInfo.name
    }
    
    func getId() -> Int{
        return self.deviceInfo.id
    }
    
    func getDescription() -> String {
        return "\(self.getName()), \(self.getId())"
    }
}
