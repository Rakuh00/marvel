//
//  ErrorScreenViewController.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

class ErrorScreenViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    //MARK: Variables
    var delegate: UIViewController?
    var messageText: String?

    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Functions
    func setUpView() {
        //modal view
        modalView.layer.cornerRadius = 4
        modalView.layer.borderWidth = 2
        modalView.layer.borderColor = Colors.redMarvelColor.cgColor
        modalView.layer.masksToBounds = true
        modalView.backgroundColor = .white
        
        //title view
        titleView.backgroundColor = Colors.redMarvelColor
        
        //title label
        titleLabel.textColor = .white
        titleLabel.font = Fonts.robotoBlack18
        titleLabel.text = "ERROR_TITLE".localized
        
        //message label
        messageLabel.font = Fonts.robotoRegular15
        if let message = messageText {
            messageLabel.text = message
        }
        
        //accept button
        acceptButton.backgroundColor = Colors.darkBackgroundColor
        if let del = delegate {
            if del.isKind(of: HomeViewController.self) || del.isKind(of: DetailViewController.self) {
                acceptButton.setTitle("BUTTON_ACCEPT".localized, for: .normal)
            }
            if del.isKind(of: SplashViewController.self) {
                acceptButton.setTitle("BUTTON_RETRY".localized, for: .normal)
            }
        }
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.titleLabel?.font = Fonts.robotoBlack18
    }

    //MARK: - Actions
    @IBAction func acceptAction(_ sender: Any) {
        if let del = delegate {
            if del.isKind(of: HomeViewController.self) {
                dismiss(animated: true)
            }
            if del.isKind(of: SplashViewController.self) {
                dismiss(animated: true) {
                    (del as! SplashViewController).getCharacterList()
                }
            }
            if del.isKind(of: DetailViewController.self) {
                presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
