//
//  DetailPresenter.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

internal final class DetailPresenter {
    
    //MARK: - VIPER Dependencies
    internal var wireframe: DetailWireframeInterface
    internal var view: DetailViewInterface
    internal var interactor: DetailInteractorInterface?
    internal var router: DetailRouterInterface
    
    //MARK: - Internal Methods
    init(wireframe: DetailWireframeInterface, view: DetailViewInterface, interactor: DetailInteractorInterface? = nil, router: DetailRouterInterface) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Input Protocol
extension DetailPresenter: DetailPresenterInterface {
    func getDetailCharacter(characterId: Int, view: DetailViewController) {
        interactor?.getDetailCharacter(characterId: characterId, view: view)
    }
    
    func setUpView() {
        wireframe.setUpView()
    }
    
    func goToModalListScreen(type: ListType, arrayList: [String]) {
        router.goToModalListScreen(type: type, arrayList: arrayList)
    }
}

//MARK: - Output Protocol
extension DetailPresenter: DetailOutputInteractorInterface {
    func showError(textError: String) {
        view.showError(textError: textError)
    }
    
    func stopLoading() {
        view.stopLoadingLottie()
    }
    
    func showModalView() {
        view.showModalView()
    }
}
