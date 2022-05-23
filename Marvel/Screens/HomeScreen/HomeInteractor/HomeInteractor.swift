//
//  HomeInteractor.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class HomeInteractor {
    
    //MARK: - VIPER Dependencies
    var presenter: HomeOutputInteractorInterface?
    var externalDM: HomeExternalDMInputProtocol?
    
    //MARK: - Internal Methods
    init() {
        externalDM = HomeExternalDM(interactor: self)
    }
}

//MARK: - Input Protocol
extension HomeInteractor: HomeInteractorInterface {
    func getCharacterList(view: HomeViewController, limit: String, text: String) {
        view.startLoadingLottie()
        externalDM?.getCharacterList(limit: limit, text: text, success: { characterModel in
            print(characterModel)
            let list = List()
            list.characterList = characterModel
            List.sharedInstance.syncList(list: list)
            view.stopLoadingLottie()
            view.reloadTableView()
        }, failure: { error in
            print(error)
            view.stopLoadingLottie()
            var message = ""
            switch error {
            case .noNetwork:
                message = "ERROR_NETWORK".localized
            default:
                message = "ERROR_SERVER_GENERIC".localized
            }
            self.presenter?.showError(textError: message)
        })
    }
    
    func registerCells(viewController: HomeViewController) {
        viewController.characterTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: viewController.listCellIdentificate)
        viewController.characterTableView.delegate = viewController
        viewController.characterTableView.dataSource = viewController
    }
}
