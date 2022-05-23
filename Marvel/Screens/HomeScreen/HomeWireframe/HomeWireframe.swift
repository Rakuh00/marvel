//
//  HomeWireframe.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal final class HomeWireframe {
    
    //MARK: - Variables
    internal var view: HomeViewController
    
    //MARK: - Internal Methods
    init(view: HomeViewController) {
        self.view = view
    }
}

//MARK: - Input Protocol
extension HomeWireframe: HomeWireframeInterface {
    
    func setView() {
        view.view.backgroundColor = Colors.darkBackgroundColor
        view.lineView.backgroundColor = Colors.grayLineColor
        view.safeAreaView.backgroundColor = Colors.darkBackgroundColor
        view.navigationView.backgroundColor = Colors.darkBackgroundColor
        view.characterTableView.alpha = 0
        view.characterTableView.backgroundColor = .white
        
        view.searchViewHeightConstraint.constant = 0
        view.searchView.backgroundColor = Colors.redMarvelColor
        view.searchView.layer.masksToBounds = true
        view.contentTexFieldView.layer.borderWidth = 2
        view.contentTexFieldView.layer.borderColor = UIColor.white.cgColor
        view.contentTexFieldView.layer.masksToBounds = true
        view.contentTexFieldView.backgroundColor = .clear
        view.searchTextField.tintColor = .white
        view.searchTextField.textColor = .white
        view.searchTextField.delegate = view
        view.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "SEARCH_PLACEHOLDER".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Fonts.robotoRegular15]
        )
    }
    
    func setLogoImageView() {
        view.logoImageView.image = UIImage(named: "marvel_logo")
    }
    
    func setUpdateButton() {
        view.updateButton.tintColor = Colors.redMarvelColor
    }
    
    func setSearchButton() {
        view.searchButton.tintColor = Colors.redMarvelColor
        view.executeSearchButton.setTitleColor(.white, for: .normal)
        view.executeSearchButton.setTitle("SEARCH_BUTTON".localized, for: .normal)
    }
    
    func setEraseSearchButton() {
        view.eraseSearchButton.tintColor = .white
    }
    
    func showList() {
        UIView.animate(withDuration: 0.3) {
            self.view.characterTableView.alpha = 1
        }
    }
    
    func hideList() {
        UIView.animate(withDuration: 0.3) {
            self.view.characterTableView.alpha = 0
        }
    }
    
    func showSearchBar(show: Bool) {
        if show {
            view.searchViewHeightConstraint.constant = 56
            UIView.animate(withDuration: 0.3) {
                self.view.view.layoutIfNeeded()
                self.view.searchButton.tintColor = .white
            }
        } else {
            view.searchViewHeightConstraint.constant = 0
            view.view.endEditing(true)
            UIView.animate(withDuration: 0.2) {
                self.view.view.layoutIfNeeded()
                self.view.searchButton.tintColor = Colors.redMarvelColor
            } completion: { _ in
                self.view.searchTextField.text = nil
            }
        }
    }
    
    func updateButtonRed() {
        UIView.animate(withDuration: 0.3) {
            self.view.updateButton.tintColor = Colors.redMarvelColor
        }
    }
    
    func updateButtonWhite() {
        UIView.animate(withDuration: 0.3) {
            self.view.updateButton.tintColor = .white
        }
    }
}
