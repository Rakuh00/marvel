//
//  DetailExternalDM.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit
import AlamofireImage

internal final class DetailExternalDM {
    
    //MARK: - VIPER Dependencies
    weak var interactor: DetailInteractor!
    
    //MARK: - Internal Methods
    init(interactor: DetailInteractor) {
        self.interactor = interactor
    }

}

//MARK: - Input Protocol
extension DetailExternalDM: DetailExternalDMInputProtocol {
    func getDetailCharacter(characterId: Int, success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void) {
        if Connection.isConnected() {
            //Real Service
            WebServiceApi.makeApiRequest(route: WebServiceRouter.characterDetail(id: characterId), responseModel: CharacterListModelResponse.self, success: { response in
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
    
    func getCharacterImage(character: CharacterModel, imageView: UIImageView) {
        if let charThumbnail = character.thumbnail, let extensionImage = character.thumbnail?.extensionImage {
            if let url = URL(string: "\(charThumbnail.path ?? "").\(extensionImage)") {
                imageView.af_setImage(withURL: url)
            } else {
                imageView.image = UIImage()
            }
        }
    }
}
