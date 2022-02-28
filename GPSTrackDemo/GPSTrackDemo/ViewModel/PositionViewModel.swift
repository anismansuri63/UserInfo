//
//  PositionViewModel.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//


import Foundation
import UIKit

class PositionViewModel: NSObject {
    
    private var positioninfo:RBPositions
    
    init(withPositions positions:RBPositions){
        self.positioninfo = positions
        super.init()
    }
    
    // Add your display logic here
    func getLatitude() -> Double{
        return self.positioninfo.latitude
    }
    
    func getLogitude() -> Double{
        return self.positioninfo.longitude
    }
    
//    func getDescription() -> String {
//        return "\(self.getName()), \(self.getId())"
//    }
}
