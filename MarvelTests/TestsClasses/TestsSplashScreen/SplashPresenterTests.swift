//
//  SplashPresenterTests.swift
//  MarvelTests
//
//  Created by RFG023ES on 23/5/22.
//

import XCTest
@testable import Marvel

class SplashPresenterTests: XCTestCase {
    
    //MARK: - VIPER Dependencies
    var wireframe: TestSplashWireframe!
    var view: TestSplashView!
    var interactor: TestSplashInteractor!
    var router: TestSplashRouter!
    var presenter: SplashPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.wireframe = TestSplashWireframe()
        self.view = TestSplashView()
        self.interactor = TestSplashInteractor()
        self.router = TestSplashRouter()
        self.presenter = SplashPresenter(wireframe: wireframe, view: view, interactor: interactor, router: router)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.wireframe = nil
        self.view = nil
        self.interactor = nil
        self.router = nil
        self.presenter = nil
        try super.tearDownWithError()
    }
    
    func testSetUpViewFunction() throws {
        presenter.setUpView()
        
        XCTAssertTrue(wireframe.isSetView, "No se ha podido configurar el diseño de la vista")
        XCTAssertTrue(wireframe.isSetLogoImageView, "No se ha podido configurar la imagen de Logo")
    }
    
    func testShowLogoFunction() throws {
        presenter.showLogo()
        
        XCTAssertTrue(wireframe.isShowLogo, "No se ha podido mostrar el Logo")
        XCTAssertTrue(interactor.isGetCharacterList, "No se ha podido llamar al servicio de getCharacterList")
    }
    
    func testGetCharacterListFunction() throws {
        presenter.getCharacterList()
        
        XCTAssertTrue(interactor.isGetCharacterList, "No se ha podido llamar al servicio de getCharacterList")
    }
    
    func testHideLogoFunction() throws {
        presenter.hideLogo()
        
        XCTAssertTrue(wireframe.isHideLogo, "No se ha podido ocultar el Logo")
    }
    
    func testGoToHomeScreenFunction() throws {
        presenter.goToHomeScreen()
        
        XCTAssertTrue(router.isGoToHomeScreen, "No se ha podido mostrar la pantalla Home")
    }
    
    func testShowErrorFunction() throws {
        let errorText = "Error"
        presenter.showError(errorText: errorText)
        
        XCTAssertTrue(router.isGoToAlertScreen, "No se ha podido mostrar la pantalla Home")
        XCTAssertEqual(router.textError, errorText, "No se ha podido llevar el mensaje de error a la vista")
    }

}

extension SplashPresenterTests {
    class TestSplashWireframe: SplashWireframeInterface {
        
        //Test Variables
        var isSetView = false
        var isSetLogoImageView = false
        var isShowLogo = false
        var isHideLogo = false
        
        func setView() {
            isSetView = true
        }
        
        func setLogoImageView() {
            isSetLogoImageView = true
        }
        
        func showLogo() {
            isShowLogo = true
        }
        
        func hideLogo() {
            isHideLogo = true
        }
        
    }
    
    class TestSplashInteractor: SplashInteractorInterface {
        var presenter: SplashOutputInteractorInterface?
        var externalDM: SplashExternalDMInputProtocol?
        
        //Test Variables
        var isGetCharacterList = false
        
        func getCharacterList() {
            isGetCharacterList = true
        }
    }
    
    final class TestSplashRouter: SplashRouterInterface {
        var navigationController: UINavigationController?
        var viewController: UIViewController?
        
        //Test Variables
        var isGoToHomeScreen = false
        var isGoToAlertScreen = false
        var textError = ""
        
        
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
        
        func goToHomeScreen() {
            isGoToHomeScreen = true
        }
        
        func goToAlertScreen(textError: String) {
            isGoToAlertScreen = true
            self.textError = textError
        }
    }
    
    class TestSplashView: SplashViewInterface {
        var presenter: SplashPresenterInterface!
        
        func getCharacterList() {}
    }
}
