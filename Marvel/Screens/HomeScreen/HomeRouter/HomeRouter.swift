//
//  HomeRouter.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class HomeRouter {
    
    //MARK: - Variables
    weak var navigationController: UINavigationController?
    weak var viewController: UIViewController?
    
    //MARK: - Internal Methods
    func instantiateViewController<T>(_ context: T?) -> UIViewController {
        let vc = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let interactor = HomeInteractor()
        let wireframe = HomeWireframe(view: vc)
        let presenter = HomePresenter(wireframe: wireframe, view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        interactor.presenter = presenter
        self.viewController = vc
        return vc
    }
}

//MARK: - Input Protocol
extension HomeRouter: HomeRouterInterface {
    
    func goToDetailView(characterId: Int, motionId: String) {
        let detailRouter = DetailRouter()
        let detailView = detailRouter.instantiateViewController(detailRouter.self) as? DetailViewController
        detailView?.characterId = characterId
        detailView?.view.frame = viewController!.view.bounds
        detailView?.modalPresentationStyle = .overFullScreen
        detailView?.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        
        viewController!.present(detailView!, animated: true, completion: nil)
    }
    
    func goToDescriptionScreen(text: String) {
        let viewDescription = DescriptionViewController()
        viewDescription.delegate = viewController as? HomeViewController
        viewDescription.text = text
        viewDescription.modalPresentationStyle = .overFullScreen
        viewDescription.modalTransitionStyle = .crossDissolve
        viewDescription.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        viewController!.present(viewDescription, animated: true, completion: nil)
    }
    
    func goToAlertScreen(textError: String) {
        let viewError = ErrorScreenViewController()
        viewError.delegate = viewController as? HomeViewController
        viewError.messageText = textError
        viewError.modalPresentationStyle = .overFullScreen
        viewError.modalTransitionStyle = .crossDissolve
        viewError.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        viewController!.present(viewError, animated: true, completion: nil)
    }
}
