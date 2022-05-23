//
//  WebServiceRetrier.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation
import Alamofire

internal final class WebServiceRetrier: RequestRetrier {

    private var retriedRequests: [String: Int] = [:]
    
    internal func should(_ manager: SessionManager,
                         retry request: Request,
                         with error: Error,
                         completion: @escaping RequestRetryCompletion) {
        
        guard let url = request.request?.url?.absoluteString else {
            removeCachedUrlRequest(url: request.request?.url?.absoluteString)
            completion(false, 0.0) // don't retry
            return
        }
        
        guard let retryCount = retriedRequests[url] else {
            retriedRequests[url] = 1
            completion(true, 1.0) // retry after 1 second
            return
        }
        
        if retryCount <= 3 {
            retriedRequests[url] = retryCount + 1
            completion(true, 1.0) // retry after 1 second
        } else {
            removeCachedUrlRequest(url: url)
            completion(false, 0.0) // don't retry
        }
    }
    
    private func removeCachedUrlRequest(url: String?) {
        guard let url = url else { return }
        retriedRequests.removeValue(forKey: url)
    }
}


