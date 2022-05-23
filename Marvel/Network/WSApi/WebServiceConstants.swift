//
//  WebServiceConstants.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation

internal final class WebServiceConstants: NSObject {

    // MARK: - ApiConfig
    struct Configuration {
        static let urlBase = "https://gateway.marvel.com:443"
        static let marvelPublicKey = "e0a95061f923febe7cd84d4a7d346a7b"
        static let marvelPrivateKey = "1db180e252d9969072256a222298e2db389e0e58"
        static let ts = "1"
        static let hashString = ts + marvelPrivateKey + marvelPublicKey
        static let contentType = "Content-Type"
        static let json = "application/json"
        static let timeoutInterval: TimeInterval = 30
    }
}
