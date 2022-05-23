//
//  DetailRouter.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

internal final class DetailRouter {
    
    //MARK: - Variables
    weak var navigationController: UINavigationController?
    weak var viewController: UIViewController?
    
    //MARK: - Internal Methods
    func instantiateViewController<T>(_ context: T?) -> UIViewController {
        let vc = DetailViewController(nibName: String(describing: DetailViewController.self), bundle: nil)
        let interactor = DetailInteractor()
        let wireframe = DetailWireframe(view: vc)
        let presenter = DetailPresenter(wireframe: wireframe, view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        interactor.presenter = presenter
        self.viewController = vc
        return vc
    }
}

//MARK: - Input Protocol
extension DetailRouter: DetailRouterInterface {
    func goToAlertScreen(textError: String) {
        let viewError = ErrorScreenViewController()
        viewError.delegate = viewController as? DetailViewController
        viewError.messageText = textError
        viewError.modalPresentationStyle = .overFullScreen
        viewError.modalTransitionStyle = .crossDissolve
        viewError.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        
        viewController!.present(viewError, animated: true, completion: nil)
    }
    
    func goToModalListScreen(type: ListType, arrayList: [String]) {
        let viewModalList = ModalListViewController()
        viewModalList.type = type
        viewModalList.arrayList = arrayList
        viewModalList.modalPresentationStyle = .overFullScreen
        viewModalList.modalTransitionStyle = .crossDissolve
        viewModalList.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
        
        viewController!.present(viewModalList, animated: true, completion: nil)
    }
}
