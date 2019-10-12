//
//  Reachability.swift
//  CustomVideoPlayer
//
//  Created by ANIS MANSURI on 21/06/19.
//  Copyright © 2019 ANIS MANSURI. All rights reserved.
//

import UIKit
import SystemConfiguration
class Reachability: NSObject {
    
    private override init() {}

    // MARK: Shared Instance
    static let shared = Reachability()
    let reachability = SCNetworkReachabilityCreateWithName(nil, "https://www.google.com/")

    /// Check if internet is available or not.
    func isNetworkReachable() -> Bool {
        guard let reachabilit = reachability else { return false }

        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachabilit, &flags)

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }

}
