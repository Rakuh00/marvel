//
//  DescriptionViewController.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK: Variables
    var delegate: HomeViewController?
    var text: String?
    
    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Functions
    func setUpView() {

        modalView.layer.cornerRadius = 4
        modalView.layer.borderWidth = 2
        modalView.layer.borderColor = Colors.redMarvelColor.cgColor
        modalView.layer.masksToBounds = true
        
        titleView.backgroundColor = Colors.redMarvelColor
        titleLabel.font = Fonts.robotoBlack20
        titleLabel.textColor = .white
        titleLabel.text = "COMMONS_DESCRIPTION".localized
        
        closeButton.backgroundColor = Colors.darkBackgroundColor
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.setTitle("BUTTON_CLOSE".localized, for: .normal)
        
        descriptionTextView.font = Fonts.robotoRegular14
        descriptionTextView.delegate = self
        
        if let descriptionText = text {
            descriptionTextView.text = descriptionText
        }
    }
    
    //MARK: - Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: - TextView Delegate
extension DescriptionViewController: UITextViewDelegate {
    
}
