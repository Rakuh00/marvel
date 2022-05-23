//
//  SplashProtocols.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

//MARK: - View
protocol SplashViewInterface {
    var presenter: SplashPresenterInterface! { get set }
    // Presenter -> ViewController
    func getCharacterList()
}

//MARK: - Presenter
protocol SplashPresenterInterface {
    var wireframe: SplashWireframeInterface { get }
    var view: SplashViewInterface { get }
    var interactor: SplashInteractorInterface? { get }
    var router: SplashRouterInterface { get }
    // ViewController -> Presenter
    func setUpView()
    func showLogo()
    func getCharacterList()
    func hideLogo()
}

//MARK: - Interactor
//Input
protocol SplashInteractorInterface {
    var presenter: SplashOutputInteractorInterface? { get set }
    var externalDM: SplashExternalDMInputProtocol? { get set }
    // Presenter -> Interactor
    func getCharacterList()
}

//Output
protocol SplashOutputInteractorInterface {
    // Interactor -> Presenter
    func showError(errorText: String)
    func goToHomeScreen()
}

//MARK: - ExternalDM
protocol SplashExternalDMInputProtocol {
    // Interactor -> External Data Manager
    func getCharacterList(success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void)
}

//MARK: - Router
protocol SplashRouterInterface {
    // Presenter -> Router
    func goToHomeScreen()
    func goToAlertScreen(textError: String)
}

//MARK: - Wireframe
protocol SplashWireframeInterface {
    // Presenter -> Wireframe
    func setView()
    func setLogoImageView()
    func showLogo()
    func hideLogo()
}


