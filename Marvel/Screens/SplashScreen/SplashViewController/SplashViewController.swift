//
//  SplashViewController.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit
import Motion

internal final class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    //MARK: - VIPER dependencies
    var presenter: SplashPresenterInterface!

    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setUpView()
        isMotionEnabled = true
        logoImageView.motionIdentifier = "logo"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.showLogo()
    }
}

//MARK: - ViewInterface Protocol
extension SplashViewController: SplashViewInterface {
    func getCharacterList() {
        presenter.getCharacterList()
    }
}
