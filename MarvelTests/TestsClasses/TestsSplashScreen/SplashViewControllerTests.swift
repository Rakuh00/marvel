//
//  SplashViewControllerTests.swift
//  MarvelTests
//
//  Created by RFG023ES on 23/5/22.
//

import XCTest
@testable import Marvel

class SplashViewControllerTests: XCTestCase {
    
    //MARK: - VIPER dependencies
    var presenter: TestSplashPresenter?
    var viewController: SplashViewController?
    var wireframe: TestSplashWireframe?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewController = SplashViewController()
        wireframe = TestSplashWireframe()
        presenter = TestSplashPresenter(wireframe: wireframe!, view: viewController!, interactor: TestSplashInteractor(), router: TestSplashRouter())
        viewController!.presenter = presenter
        viewController?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        presenter = nil
        wireframe = nil
        try super.tearDownWithError()
    }

    func testViewDidLoadFunction() throws {
        viewController?.viewDidLoad()
        
        XCTAssertTrue(presenter?.isSetUpView ?? false, "No se ha podido iniciar la configuración de la vista")
    }
    
    func testViewDidAppearFunction() throws {
        viewController?.viewDidAppear(true)
        
        XCTAssertTrue(presenter?.isSetLogo ?? false, "No se ha podido iniciar la función viewDidAppear")
    }
    
    func testGetCharacterListFunction() throws {
        viewController?.getCharacterList()
        
        XCTAssertTrue(presenter?.isGetCharacterList ?? false, "No se ha podido iniciar la función viewDidAppear")
    }

}

extension SplashViewControllerTests {
    class TestSplashPresenter: SplashPresenterInterface {
        var wireframe: SplashWireframeInterface
        var view: SplashViewInterface
        var interactor: SplashInteractorInterface?
        var router: SplashRouterInterface
        
        //Test Variables
        var isSetUpView = false
        var isSetLogo = false
        var isGetCharacterList = false
        
        init(wireframe: SplashWireframeInterface, view: SplashViewInterface, interactor: SplashInteractorInterface?, router: SplashRouterInterface) {
            self.wireframe = wireframe
            self.view = view
            self.interactor = interactor
            self.router = router
        }
        
        func getCharacterList() {
            isGetCharacterList = true
        }
        
        func setUpView() {
            isSetUpView = true
        }
        
        func showLogo() {
            isSetLogo = true
        }
        
        func hideLogo() {}
    }
    
    class TestSplashWireframe: SplashWireframeInterface {
        func setView() {}
        func setLogoImageView() {}
        func showLogo() {}
        func hideLogo() {}
    }
    
    class TestSplashInteractor: SplashInteractorInterface {
        var presenter: SplashOutputInteractorInterface?
        var externalDM: SplashExternalDMInputProtocol?
        
        func getCharacterList() {}
    }
    
    final class TestSplashRouter: SplashRouterInterface {
        var navigationController: UINavigationController?
        var viewController: UIViewController?
        
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
        
        func goToHomeScreen() {}
        func goToAlertScreen(textError: String) {}
    }
}
