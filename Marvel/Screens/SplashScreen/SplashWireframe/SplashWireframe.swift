//
//  SplashWireframe.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class SplashWireframe {
    
    //MARK: - Variables
    internal var view: SplashViewController
    
    //MARK: - Internal Methods
    init(view: SplashViewController) {
        self.view = view
    }
}

//MARK: - Input Protocol
extension SplashWireframe: SplashWireframeInterface {
    
    func setView() {
        view.view.backgroundColor = Colors.darkBackgroundColor
    }
    
    func setLogoImageView() {
        view.logoImageView.alpha = 0
        view.logoImageView.image = UIImage(named: "marvel_logo")
    }
    
    func showLogo() {
        UIView.animate(withDuration: 0.3) {
            self.view.logoImageView.alpha = 1
        }
    }
    
    func hideLogo() {
        UIView.animate(withDuration: 0.2) {
            self.view.logoImageView.alpha = 0
        }
    }
}
