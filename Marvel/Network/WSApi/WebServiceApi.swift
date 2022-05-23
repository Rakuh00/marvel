//
//  WebServiceApi.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation
import Alamofire

internal final class WebServiceApi {
    
    private static var AFManager: Alamofire.SessionManager = {
        var serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        serverTrustPolicies = [
            "gateway.marvel.com": .disableEvaluation,
            "i.annihil.us": .disableEvaluation
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        let manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        manager.retrier = WebServiceRetrier()
        return manager
    }()
    
    static func makeApiRequest<T:Decodable>(route: WebServiceRouter,
                                            responseModel: T.Type,
                                            success: @escaping(T) -> Void,
                                            failed: @escaping(DataError.ServiceError) -> Void) {
        
        AFManager.request(route).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    if data.count == 0 {
                        success(ResponseOk.init(responseCode: 200) as! T)
                    } else {
                        let jsonDecoder = JSONDecoder()
                        let responseObject = try jsonDecoder.decode(responseModel.self, from: data)
                        success(responseObject)
                    }
                } catch {
                    failed(DataError.ServiceError.parsingError)
                }
            case .failure(let error):
                failed(DataError.ServiceError.getServiceError(error: error))
            }
        }
    }
}
