//
//  SplashPresenter.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class SplashPresenter {
    
    //MARK: - VIPER Dependencies
    internal var wireframe: SplashWireframeInterface
    internal var view: SplashViewInterface
    internal var interactor: SplashInteractorInterface?
    internal var router: SplashRouterInterface
    
    //MARK: - Internal Methods
    init(wireframe: SplashWireframeInterface, view: SplashViewInterface, interactor: SplashInteractorInterface? = nil, router: SplashRouterInterface) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Input Protocol
extension SplashPresenter: SplashPresenterInterface {
    
    func setUpView() {
        wireframe.setView()
        wireframe.setLogoImageView()
    }
    
    func showLogo() {
        wireframe.showLogo()
        interactor?.getCharacterList()
    }
    
    func getCharacterList() {
        interactor?.getCharacterList()
    }
    
    func hideLogo() {
        wireframe.hideLogo()
    }
}

//MARK: - Output Protocol
extension SplashPresenter: SplashOutputInteractorInterface {
    
    func goToHomeScreen() {
        router.goToHomeScreen()
    }
    
    func showError(errorText: String) {
        router.goToAlertScreen(textError: errorText)
    }
}
