//
//  RBDevices.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import Foundation

import UIKit

struct RBData:Codable {
    var data:[RBDevices]
    
}
struct RBDevices:Codable {
    var name:String
    var id:Int
    
    init(withName name:String,andID id:Int) {
        self.name = name
        self.id = id
    }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.id, forKey: .id)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
    }
        
    enum CodingKeys:String,CodingKey {
        case name
        case id
    }
}

