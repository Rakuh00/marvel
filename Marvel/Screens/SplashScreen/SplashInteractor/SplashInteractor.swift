//
//  SplashInteractor.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class SplashInteractor {
    
    //MARK: - VIPER Dependencies
    var presenter: SplashOutputInteractorInterface?
    var externalDM: SplashExternalDMInputProtocol?
    
    //MARK: - Internal Methods
    init() {
        externalDM = SplashExternalDM(interactor: self)
    }
}

//MARK: - Input Protocol
extension SplashInteractor: SplashInteractorInterface {
    func getCharacterList() {
        externalDM?.getCharacterList(success: { characterModel in
            print(characterModel)
            let list = List()
            list.characterList = characterModel
            List.sharedInstance.syncList(list: list)
            self.presenter?.goToHomeScreen()
        }, failure: { error in
            print(error)
            var message = ""
            switch error {
            case .noNetwork:
                message = "ERROR_NETWORK".localized
            default:
                message = "ERROR_SERVER_GENERIC".localized
            }
            self.presenter?.showError(errorText: message)
        })
    }
}
