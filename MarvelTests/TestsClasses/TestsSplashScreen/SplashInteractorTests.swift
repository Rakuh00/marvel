//
//  SplashInteractorTests.swift
//  MarvelTests
//
//  Created by RFG023ES on 23/5/22.
//

import XCTest
@testable import Marvel

class SplashInteractorTests: XCTestCase {
    
    //MARK: - VIPER Dependencies
    var presenter: TestSplashPresenter?
    var presenterInput: TestSplashPresenterInput?
    var externalDM: TestSplashExternalDM?
    var interactor: SplashInteractor?
    var wireframe: TestSplashWireframe?
    var view: TestSplashView?
    var router: TestSplashRouter?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = TestSplashPresenter()
        self.externalDM = TestSplashExternalDM()
        self.wireframe = TestSplashWireframe()
        self.view = TestSplashView()
        self.interactor = SplashInteractor()
        self.interactor?.presenter = presenter
        self.interactor?.externalDM = externalDM
        self.router = TestSplashRouter()
        self.presenterInput = TestSplashPresenterInput(wireframe: wireframe!, view: view!, interactor: interactor!, router: router!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
        self.presenterInput = nil
        self.externalDM = nil
        self.interactor = nil
        self.wireframe = nil
        self.view = nil
        self.router = nil
        try super.tearDownWithError()
    }
    
    static func load<T>(_ type: T.Type,
                        fromMock resource: String,
                        success: @escaping(T) -> (),
                        failed: @escaping(DataError.ServiceError) -> ()) where T: Decodable {
        
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            failed(.mockNotFound(name: resource))
            return
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(T.self, from: data)
            success(response)
        } catch {
            failed(.parsingError)
        }
    }
    
    func testGetCharacterListFunctionOk() throws {
        interactor?.getCharacterList()
        
        var isCallOk = false
        if externalDM?.characterList.status != nil {
            print("true")
            isCallOk = true
        }
        XCTAssertTrue(isCallOk, "No se ha podido obtener la lista de heroes")
    }
    
    func testGetCharacterListFunctionKo() throws {
        externalDM?.isFailed = true
        interactor?.getCharacterList()
        
        var isCallOk = true
        if "\(externalDM?.errorService ?? .badRequest)" == "noNetwork" {
            print("true")
            isCallOk = false
        }
        XCTAssertFalse(isCallOk, "No se ha podido obtener el error")
    }
}

extension SplashInteractorTests {
    
    class TestSplashPresenterInput: SplashPresenterInterface {
        var wireframe: SplashWireframeInterface
        var view: SplashViewInterface
        var interactor: SplashInteractorInterface?
        var router: SplashRouterInterface
        
        init(wireframe: SplashWireframeInterface, view: SplashViewInterface, interactor: SplashInteractorInterface, router: SplashRouterInterface) {
            self.wireframe = wireframe
            self.view = view
            self.interactor = interactor
            self.router = router
        }
        
        func setUpView() {}
        func showLogo() {}
        func getCharacterList() {}
        func hideLogo() {}
    }
    
    class TestSplashPresenter: SplashOutputInteractorInterface {
        func showError(errorText: String) {}
        func goToHomeScreen() {}
    }
    
    final class TestSplashExternalDM: SplashExternalDMInputProtocol {
        var isFailed = false
        var characterList = CharacterListModel()
        var errorService = DataError.ServiceError.badRequest
        
        func getCharacterList(success succeeded: @escaping (CharacterListModel) -> Void, failure failed: @escaping (DataError.ServiceError) -> Void) {
            load(CharacterListModelResponse.self, fromMock: "characters") { response in
                let characterModel = CharacterListModelBinding.bind(response)
                if self.isFailed {
                    let error = DataError.ServiceError.noNetwork
                    self.errorService = error
                    failed(error)
                } else {
                    self.characterList = characterModel
                    succeeded(characterModel)
                }
            } failed: { error in
                failed(error)
            }
        }
    }
    
    class TestSplashWireframe: SplashWireframeInterface {
        func setView() {}
        func setLogoImageView() {}
        func showLogo() {}
        func hideLogo() {}
    }
    
    class TestSplashView: SplashViewInterface {
        var presenter: SplashPresenterInterface!
        
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





