//
//  HomeProtocols.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


//MARK: - View
protocol HomeViewInterface {
    var presenter: HomePresenterInterface! { get set }
    // Presenter -> ViewController
    func startLoadingLottie()
    func stopLoadingLottie()
    func showError(textError: String)
    func goToDescriptionScreen(text: String)
}

//MARK: - Presenter
protocol HomePresenterInterface {
    var wireframe: HomeWireframeInterface { get }
    var view: HomeViewInterface { get }
    var interactor: HomeInteractorInterface? { get }
    var router: HomeRouterInterface { get }
    // ViewController -> Presenter
    func setUpView(viewController: HomeViewController)
    func showList()
    func hideList()
    func showSearchBar(show: Bool)
    func getCharacterList(view: HomeViewController, limit: String, text: String)
    func goToDetail(characterId: Int, motionId: String)
    func goToDescriptionScreen(text: String)
}

//MARK: - Interactor
//Input
protocol HomeInteractorInterface {
    var presenter: HomeOutputInteractorInterface? { get set }
    var externalDM: HomeExternalDMInputProtocol? { get set }
    // Presenter -> Interactor
    func getCharacterList(view: HomeViewController, limit: String, text: String)
    func registerCells(viewController: HomeViewController)
}

//Output
protocol HomeOutputInteractorInterface {
    // Interactor -> Presenter
    func showError(textError: String)
}

//MARK: - ExternalDM
protocol HomeExternalDMInputProtocol {
    // Interactor -> External Data Manager
    func getCharacterList(limit: String, text: String, success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void)
}

//MARK: - Router
protocol HomeRouterInterface {
    // Presenter -> Router
    func goToDetailView(characterId: Int, motionId: String)
    func goToDescriptionScreen(text: String)
    func goToAlertScreen(textError: String)
}

//MARK: - Wireframe
protocol HomeWireframeInterface {
    // Presenter -> Wireframe
    func setView()
    func setLogoImageView()
    func setUpdateButton()
    func setSearchButton()
    func setEraseSearchButton()
    func showList()
    func hideList()
    func showSearchBar(show: Bool)
    func updateButtonRed()
    func updateButtonWhite()
}
