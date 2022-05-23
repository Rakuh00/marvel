//
//  WebServiceRouter.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation
import Alamofire
import CommonCrypto

protocol WebServiceConfiguration: Alamofire.URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

internal enum WebServiceRouter: WebServiceConfiguration {
    case characterList(limit: String, text: String)
    case characterDetail(id: Int)
    
    
    // MARK: - Methods
    var method: HTTPMethod {
        switch self {
        case .characterList:
            return HTTPMethod.get
        case .characterDetail:
            return HTTPMethod.get
        }
    }
    
    // MARK: - Paths
    var path: String {
        switch self {
        case .characterList(limit: let limit, text: let text):
            if text == "" {
                return "/v1/public/characters?limit=\(limit)"
            } else {
                let newTextName = text.replacingOccurrences(of: " ", with: "%20")
                return "/v1/public/characters?nameStartsWith=\(newTextName)&limit=\(limit)"
            }
        case .characterDetail(id: let id):
            return "/v1/public/characters/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .characterList:
            return nil
        case .characterDetail:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest: URLRequest
        let baseURL = WebServiceConstants.Configuration.urlBase
        let marvelPublicKey = WebServiceConstants.Configuration.marvelPublicKey
        let ts = WebServiceConstants.Configuration.ts
        let hash = MD5(WebServiceConstants.Configuration.hashString) ?? ""
        
        switch self {
        case .characterList:
            urlRequest = URLRequest(url: URL(string: "\(baseURL)\(path)&ts=\(ts)&apikey=\(marvelPublicKey)&hash=\(String(describing: hash))")!)
            urlRequest = try Alamofire.URLEncoding.httpBody.encode(urlRequest, with: self.parameters)
            break
        case .characterDetail:
            urlRequest = URLRequest(url: URL(string: "\(baseURL)\(path)?ts=\(ts)&apikey=\(marvelPublicKey)&hash=\(String(describing: hash))")!)
            urlRequest = try Alamofire.JSONEncoding.default.encode(urlRequest, with: self.parameters)
            break
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = WebServiceConstants.Configuration.timeoutInterval

        return urlRequest
    }
}

// MARK: - Private Methods
private func MD5(_ string: String) -> String? {
    let length = Int(CC_MD5_DIGEST_LENGTH)
    var digest = [UInt8](repeating: 0, count: length)
    
    if let d = string.data(using: String.Encoding.utf8) {
        _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
            CC_MD5(body, CC_LONG(d.count), &digest)
        }
    }
    
    return (0..<length).reduce("") {
        $0 + String(format: "%02x", digest[$1])
    }
}

private func fromBase64(_ string: String) -> String? {
    let data = string.data(using: .utf8)
    return data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
}


