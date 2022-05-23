//
//  Connection.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation
import Alamofire

internal final class Connection {
    
    // MARK: - Internal Methods
    static func isConnected() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
