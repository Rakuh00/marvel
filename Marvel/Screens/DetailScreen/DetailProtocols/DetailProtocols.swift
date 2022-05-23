//
//  DetailProtocols.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

//MARK: - View
protocol DetailViewInterface {
    var presenter: DetailPresenterInterface! { get set }
    // Presenter -> ViewController
    func startLoadingLottie()
    func stopLoadingLottie()
    func showError(textError: String)
    func showModalView()
}

//MARK: - Presenter
protocol DetailPresenterInterface {
    var wireframe: DetailWireframeInterface { get }
    var view: DetailViewInterface { get }
    var interactor: DetailInteractorInterface? { get }
    var router: DetailRouterInterface { get }
    // ViewController -> Presenter
    func getDetailCharacter(characterId: Int, view: DetailViewController)
    func setUpView()
    func goToModalListScreen(type: ListType, arrayList: [String])
}

//MARK: - Interactor
//Input
protocol DetailInteractorInterface {
    var presenter: DetailOutputInteractorInterface? { get set }
    var externalDM: DetailExternalDMInputProtocol? { get set }
    // Presenter -> Interactor
    func getDetailCharacter(characterId: Int, view: DetailViewController)
}

//Output
protocol DetailOutputInteractorInterface {
    // Interactor -> Presenter
    func showError(textError: String)
    func stopLoading()
    func showModalView()
}

//MARK: - ExternalDM
protocol DetailExternalDMInputProtocol {
    // Interactor -> External Data Manager
    func getDetailCharacter(characterId: Int, success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void)
    func getCharacterImage(character: CharacterModel, imageView: UIImageView)
}

//MARK: - Router
protocol DetailRouterInterface {
    // Presenter -> Router
    func goToAlertScreen(textError: String)
    func goToModalListScreen(type: ListType, arrayList: [String])
}

//MARK: - Wireframe
protocol DetailWireframeInterface {
    // Presenter -> Wireframe
    func setUpView()
}
