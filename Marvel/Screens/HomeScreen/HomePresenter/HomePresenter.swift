//
//  HomePresenter.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class HomePresenter {
    
    //MARK: - VIPER Dependencies
    internal var wireframe: HomeWireframeInterface
    internal var view: HomeViewInterface
    internal var interactor: HomeInteractorInterface?
    internal var router: HomeRouterInterface
    
    //MARK: - Internal Methods
    init(wireframe: HomeWireframeInterface, view: HomeViewInterface, interactor: HomeInteractorInterface? = nil, router: HomeRouterInterface) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - Input Protocol
extension HomePresenter: HomePresenterInterface {
    func setUpView(viewController: HomeViewController) {
        wireframe.setView()
        wireframe.setLogoImageView()
        wireframe.setUpdateButton()
        wireframe.setSearchButton()
        wireframe.setEraseSearchButton()
        interactor?.registerCells(viewController: viewController)
    }
    
    func showList() {
        wireframe.showList()
    }
    
    func hideList() {
        wireframe.hideList()
    }
    
    func showSearchBar(show: Bool) {
        wireframe.showSearchBar(show: show)
    }
    
    func getCharacterList(view: HomeViewController, limit: String, text: String) {
        interactor?.getCharacterList(view: view, limit: limit, text: text)
    }
    
    func goToDetail(characterId: Int, motionId: String) {
        router.goToDetailView(characterId: characterId, motionId: motionId)
    }
    
    func goToDescriptionScreen(text: String) {
        router.goToDescriptionScreen(text: text)
    }
}

//MARK: - Output Protocol
extension HomePresenter: HomeOutputInteractorInterface {
    func showError(textError: String) {
        view.showError(textError: textError)
    }
}
