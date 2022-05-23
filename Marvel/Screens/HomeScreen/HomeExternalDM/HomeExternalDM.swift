//
//  HomeExternalDM.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class HomeExternalDM {
    
    //MARK: - VIPER Dependencies
    weak var interactor: HomeInteractor!
    
    //MARK: - Internal Methods
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
}

//MARK: - Input Protocol
extension HomeExternalDM: HomeExternalDMInputProtocol {
    func getCharacterList(limit: String, text: String, success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void) {
        if Connection.isConnected() {
            //Real Service
            WebServiceApi.makeApiRequest(route: WebServiceRouter.characterList(limit: limit, text: text), responseModel: CharacterListModelResponse.self, success: { response in
                let characterList = CharacterListModelBinding.bind(response)
                succeeded(characterList)
            }) { error in
                switch error {
                case .unauthorized:
                    failed(error)
                default:
                    failed(error)
                }
            }
        } else {
            let error = DataError.ServiceError.noNetwork
            failed(error)
        }
    }
}

