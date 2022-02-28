//
//  PositionList.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//


import UIKit

protocol PositionListModelProtocol:class {
    func didReceive()
    func failedToGetPositions(withError error:Error)
}

class PositionListModel: NSObject {
    weak private var delegate:PositionListModelProtocol?
    var positions:[RBPositions] = []
    init(withDelegate delegate:PositionListModelProtocol){
        self.delegate = delegate
    }
    
    
    func fetchPositionList(sessionId session:String,userID userAppId:String) -> Void{
        MSServiceManager.shared.getPositionList {[weak self] (list, error) in
            if let error = error{
                self?.delegate?.failedToGetPositions(withError: error)
            }else{
                self?.positions = list
                self?.delegate?.didReceive()
            }
        }
    }
}
