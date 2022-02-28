//
//  DeviceListModel.swift
//  GPSTrackDemo
//
//  Created by Ruchika Bokadia on 06/01/22.
//

import UIKit

protocol DeviceListModelProtocol:class {
    func didReceive(devices aryCountries:[GPSTrackViewModel]) -> Void
    func failedToGetDevices(withError error:Error) -> Void
}

class DeviceListModel: NSObject {
    
    weak private var delegate:DeviceListModelProtocol?
    
    init(withDelegate delegate:DeviceListModelProtocol){
        self.delegate = delegate
    }
    
    
    func fetchDeviceList() -> Void{
        MSServiceManager.shared.getDeviceList {[weak self] (aryDevices, error) in
            if let error = error{
                self?.delegate?.failedToGetDevices(withError: error)
            }else{
                var aryDeviceViewModel:[GPSTrackViewModel] = []
                for device in aryDevices{
                    print(device)
                   aryDeviceViewModel.append(GPSTrackViewModel.init(withDevices: device))
                }
                self?.delegate?.didReceive(devices: aryDeviceViewModel)
            }
        }
    }
}
