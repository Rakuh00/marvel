//
//  SplashRouter.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class SplashRouter {
    
    //MARK: - Variables
    weak var navigationController: UINavigationController?
    weak var viewController: UIViewController?
    
    //MARK: - Internal Methods
    func instantiateViewController<T>(_ context: T?) -> UIViewController {
        let vc = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
        let interactor = SplashInteractor()
        let wireframe = SplashWireframe(view: vc)
        let presenter = SplashPresenter(wireframe: wireframe, view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        interactor.presenter = presenter
        self.viewController = vc
        return vc
    }
}

//MARK: - Input Protocol
extension SplashRouter: SplashRouterInterface {
    
    func goToHomeScreen() {
        let homeRouter = HomeRouter()
        let homeView = homeRouter.instantiateViewController(homeRouter.self) as? HomeViewController
        homeView?.view.frame = viewController!.view.bounds
        homeView?.modalPresentationStyle = .overFullScreen
        
        viewController!.present(homeView!, animated: true, completion: nil)
    }
    
    func goToAlertScreen(textError: String) {
        let viewError = ErrorScreenViewController()
        viewError.delegate = viewController as? SplashViewController
        viewError.messageText = textError
        viewError.modalPresentationStyle = .overFullScreen
        viewError.modalTransitionStyle = .crossDissolve
        viewError.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        
        viewController!.present(viewError, animated: true, completion: nil)
    }
}
