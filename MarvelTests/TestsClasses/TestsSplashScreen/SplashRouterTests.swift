//
//  SplashRouterTests.swift
//  MarvelTests
//
//  Created by RFG023ES on 23/5/22.
//

import XCTest
@testable import Marvel

class SplashRouterTests: XCTestCase {
    
    var navigationController: UINavigationController?
    var viewController: UIViewController?
    var presenter: TestSplashPresenter?
    var interactor: TestSplashInteractor?
    var router: SplashRouter?
    var wireframe: TestSplashWireframe?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let vc = SplashViewController(nibName: String(describing: SplashViewController.self), bundle: nil)
        self.viewController = vc
        self.interactor = TestSplashInteractor()
        self.router = SplashRouter()
        self.router?.viewController = self.viewController
        self.wireframe = TestSplashWireframe()
        self.presenter = TestSplashPresenter(view: viewController as! SplashViewController, interactor: interactor!, router: self.router!, wireframe: wireframe!)
        (viewController as! SplashViewController).presenter = self.presenter
        viewController?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        navigationController = nil
        router = nil
        interactor = nil
        wireframe = nil
        presenter = nil
        try super.tearDownWithError()
    }
    
    func testGoToHomeScreenFunction() throws {
        router?.goToHomeScreen()
        
        var isPresentHome = false
        if ((viewController?.presentationController?.isKind(of: HomeViewController.self)) != nil) {
            print("true")
            isPresentHome = true
        }
        XCTAssertTrue(isPresentHome, "No se ha podido presentar la pantalla de Home")
    }
    
    func testGoToAlertScreenFunction() throws {
        let errorText = "Error"
        router?.goToAlertScreen(textError: errorText)
        
        var isPresentHome = false
        if ((viewController?.presentationController?.isKind(of: ErrorScreenViewController.self)) != nil) {
            print("true")
            isPresentHome = true
        }
        XCTAssertTrue(isPresentHome, "No se ha podido presentar la pantalla de Alerta")
    }

}

extension SplashRouterTests {
    final class TestSplashPresenter: SplashPresenterInterface {
        var wireframe: SplashWireframeInterface
        var view: SplashViewInterface
        var interactor: SplashInteractorInterface?
        var router: SplashRouterInterface
        
        init(view: SplashViewController, interactor: SplashInteractorInterface, router: SplashRouter, wireframe: SplashWireframeInterface) {
            self.view = view
            self.interactor = interactor
            self.router = router
            self.wireframe = wireframe
        }
        
        func setUpView() {}
        func showLogo() {}
        func getCharacterList() {}
        func hideLogo() {}
    }
    
    class TestSplashInteractor: SplashInteractorInterface {
        var presenter: SplashOutputInteractorInterface?
        var externalDM: SplashExternalDMInputProtocol?
        
        func getCharacterList() {}
    }
    
    class TestSplashWireframe: SplashWireframeInterface {
        func setView() {}
        func setLogoImageView() {}
        func showLogo() {}
        func hideLogo() {}
    }
}
