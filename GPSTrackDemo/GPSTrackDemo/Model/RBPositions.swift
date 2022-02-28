//
//  RBPositions.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 07/01/22.
//

import Foundation

import UIKit

struct RBPositionData:Codable {
    var data:[RBPositions]
    
}
struct RBPositions:Codable {
    var latitude:Double
    var longitude:Double
    
    init(withName latitude:Double,andID longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.latitude, forKey: .latitude)
        try container.encode(self.longitude, forKey: .longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
        
    enum CodingKeys:String,CodingKey {
        case latitude
        case longitude
    }
}


