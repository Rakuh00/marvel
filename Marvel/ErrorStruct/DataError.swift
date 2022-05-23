//
//  DataError.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import Foundation
import Alamofire

enum DataError: LocalizedError {

    //MARK: Persistence Errors
    case persistenceError(PersistenceError)
    case serviceError(ServiceError)
    case localAuthError(String)
    
    public var errorDescription: String {
        switch self {
        case .persistenceError(let error):
            return error.errorDescription
        case .serviceError(let error):
            return error.errorDescription
        case .localAuthError(let description):
            return description
        }
    }
    
    public var requestCancelled: Bool {
        switch self {
        case .serviceError(let serviceError):
            switch serviceError {
            case .connectionCancelled:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
    
    enum PersistenceError: LocalizedError {
        case managedObjectContextNotFound
        case persistenceStoreNotFound
        case couldNotSaveObject
        case couldNotDeleteObject
        case couldNotUpdateObject
        case objectNotFound
        
        public var errorDescription: String {
            switch self {
            case .managedObjectContextNotFound:
                return "Error reading from database"
            case .persistenceStoreNotFound:
                return "Error accessing the database"
            case .couldNotSaveObject:
                return "Error Saving in database"
            case .couldNotDeleteObject:
                return "Error Deleting in database"
            case .couldNotUpdateObject:
                return "Error updating database"
            case .objectNotFound:
                return "Element not found in the database"
            }
        }
    }
    
    //MARK: Server Errors
    enum ServiceError: LocalizedError {
        case serviceError(message: String)
        case unexpected
        case noNetwork
        case notSupported
        case busyServer
        case mockNotFound(name: String)
        case unparseable
        case urlNotRetrieved
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case business
        case internalServer
        case unknown(errorDescription: String)
        case connectionCancelled
        case timedOut
        case connectionLost
        case cannotConnect
        case redirects
        case noContent
        case parsingError
        case managingFilesError
        case refreshTokenError
        
        public var errorDescription: String {
            switch self{
            case .serviceError(let message):
                return message
            case .unexpected, .business:
                return "An error has occurred"
            case .noNetwork:
                return "The connection failed because the device is not connected to the internet"
            case .notSupported:
                return "This iOS version does not support this feature"
            case .busyServer:
                return "The connection to the server was dropped, highly overloaded server"
            case .mockNotFound(let name):
                return "Could not find mocked response named \(name)"
            case .unparseable:
                return "Server response could not be parsed"
            case .urlNotRetrieved:
                return "The requested URL could not be retrieved"
            case .badRequest:
                return "The connection failed due to a malformed URL"
            case .unauthorized, .forbidden:
                return "You have no permissions to perform this action"
            case .notFound:
                return "The server has not found anything matching the request"
            case .internalServer:
                return "The connection received an invalid server response"
            case .unknown(let errorDescription):
                return errorDescription
            case .connectionCancelled:
                return "The connection was cancelled"
            case .timedOut:
                return "The connection timed out"
            case .connectionLost:
                return "The connection failed because the network connection was lost"
            case .cannotConnect:
                return "The connection failed because a connection cannot be made to the server"
            case .redirects:
                return "The connection failed due to too many redirects"
            case .noContent:
                return "The response retrieved by the connection is zero bytes"
            case .parsingError:
                return "There was a problem managing the info from the server"
            case .managingFilesError:
                return "There was a problem managing files from the server"
            case .refreshTokenError:
                return "An authentication error has occurred"
            }
        }
        
        static func getServiceError(error: Error) -> ServiceError {
            if let error = error as? AFError {
                return mapServiceError(error: error)
            } else {
                return mapServiceError(error: error as NSError)
            }
        }
        
        static func mapServiceError(error: AFError) -> ServiceError {
            switch error.responseCode {
            case 400:
                return .badRequest
            case 401:
                return .unauthorized
            case 403:
                return .forbidden
            case 404:
                return .notFound
            case 409:
                return .business
            case 500:
                return .internalServer
            case 408:
                return .timedOut
            default:
                return .unknown(errorDescription: error.localizedDescription)
            }
        }
        
        static func mapServiceError(error: NSError) -> ServiceError {
            switch error.code {
            case 000:
                return .unexpected
            case 001, -60, -1009:
                return .noNetwork
            case 003:
                return .notSupported
            case 302:
                return .busyServer
            case 303:
                return .unparseable
            case 305:
                return .urlNotRetrieved
            case -1000:
                return .badRequest
            case -1102:
                return .unauthorized
            case -1016:
                return .forbidden
            case 409:
                return .business
            case -1011:
                return .internalServer
            case -999:
                return .connectionCancelled
            case -1001:
                return .timedOut
            case -1004:
                return .cannotConnect
            case -1005:
                return .connectionLost
            case -1007:
                return .redirects
            default:
                return .unknown(errorDescription: error.localizedDescription)
            }
        }
    }    
}
