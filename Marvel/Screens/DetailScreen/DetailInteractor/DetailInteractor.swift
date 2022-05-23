//
//  DetailInteractor.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

internal final class DetailInteractor {
    
    //MARK: - VIPER Dependencies
    var presenter: DetailOutputInteractorInterface?
    var externalDM: DetailExternalDMInputProtocol?
    
    //MARK: - Internal Methods
    init() {
        externalDM = DetailExternalDM(interactor: self)
    }
    
    func setInfo(view: DetailViewController, character: CharacterListModel) {
        view.nameLabel.text = character.data?.results?.first?.name?.uppercased()
        view.descriptionLabel.text = character.data?.results?.first?.description
        view.comicsNumberLabel.text = String(character.data?.results?.first?.comics?.available ?? 0)
        view.storiesNumberLabel.text = String(character.data?.results?.first?.stories?.available ?? 0)
        view.eventsNumberLabel.text = String(character.data?.results?.first?.events?.available ?? 0)
        view.seriesNumberLabel.text = String(character.data?.results?.first?.series?.available ?? 0)
        
        if let characterModel = character.data?.results?.first {
            externalDM?.getCharacterImage(character: characterModel, imageView: view.characterImageView)
            view.characterModel = characterModel
        }
        presenter?.stopLoading()
        presenter?.showModalView()
    }
}

//MARK: - Input Protocol
extension DetailInteractor: DetailInteractorInterface {
    func getDetailCharacter(characterId: Int, view: DetailViewController) {
        externalDM?.getDetailCharacter(characterId: characterId, success: { characterModel in
            print(characterModel)
            self.setInfo(view: view, character: characterModel)
        }, failure: { error in
            print(error)
            var textError = ""
            switch error {
            case .noNetwork:
                textError = "ERROR_NETWORK".localized
            default:
                textError = "ERROR_SERVER_GENERIC".localized
            }
            self.presenter?.showError(textError: textError)
        })
    }
}
