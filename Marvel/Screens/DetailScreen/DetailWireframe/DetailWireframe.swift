//
//  DetailWireframe.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit

internal final class DetailWireframe {
    
    //MARK: - Variables
    internal var view: DetailViewController
    
    //MARK: - Internal Methods
    init(view: DetailViewController) {
        self.view = view
    }

}

//MARK: - Input Protocol
extension DetailWireframe: DetailWireframeInterface {
    
    func setUpView() {
        view.modalView.layer.cornerRadius = 4
        view.modalView.backgroundColor = Colors.darkBackgroundColor
        view.modalView.layer.borderWidth = 2
        view.modalView.layer.borderColor = Colors.grayLineColor.cgColor
        view.modalView.layer.masksToBounds = true
        view.modalView.alpha = 0
        
        view.nameView.backgroundColor = Colors.redMarvelColor
        
        view.nameLabel.font = Fonts.robotoBlack20
        view.nameLabel.adjustsFontSizeToFitWidth = true
        view.nameLabel.minimumScaleFactor = 0.5
        view.nameLabel.textColor = .white
        
        view.characterImageView.layer.cornerRadius = 20
        view.characterImageView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.characterImageView.layer.masksToBounds = true
        view.characterImageView.backgroundColor = Colors.darkBackgroundColor
        
        view.descriptionView.backgroundColor = Colors.darkBackgroundColor
        view.descriptionLabel.font = Fonts.robotoRegular14
        view.descriptionLabel.textColor = .white
        
        view.descriptionTitleLabel.font = Fonts.robotoBlack20
        view.descriptionTitleLabel.textColor = .white
        view.descriptionTitleLabel.text = "COMMONS_DESCRIPTION".localized
        
        view.comicsView.backgroundColor = .white
        view.comicsView.layer.borderWidth = 2
        view.comicsView.layer.borderColor = Colors.grayLineColor.cgColor
        view.comicsView.layer.masksToBounds = true
        view.storiesView.backgroundColor = .white
        view.storiesView.layer.borderWidth = 2
        view.storiesView.layer.borderColor = Colors.grayLineColor.cgColor
        view.storiesView.layer.masksToBounds = true
        view.eventsView.backgroundColor = .white
        view.eventsView.layer.borderWidth = 2
        view.eventsView.layer.borderColor = Colors.grayLineColor.cgColor
        view.eventsView.layer.masksToBounds = true
        view.seriesView.backgroundColor = .white
        view.seriesView.layer.borderWidth = 2
        view.seriesView.layer.borderColor = Colors.grayLineColor.cgColor
        view.seriesView.layer.masksToBounds = true
        
        view.closeButton.backgroundColor = Colors.redMarvelColor
        view.closeButton.titleLabel?.font = Fonts.robotoBlack20
        view.closeButton.setTitleColor(.white, for: .normal)
        view.closeButton.setTitle("BUTTON_CLOSE".localized, for: .normal)
        
        view.comicsTitleView.backgroundColor = Colors.darkBackgroundColor
        view.seriesTitleView.backgroundColor = Colors.darkBackgroundColor
        view.eventsTitleView.backgroundColor = Colors.darkBackgroundColor
        view.storiesTitleView.backgroundColor = Colors.darkBackgroundColor
        
        view.comicsInfoButton.tintColor = Colors.redMarvelColor
        view.storiesInfoButton.tintColor = Colors.redMarvelColor
        view.eventsInfoButton.tintColor = Colors.redMarvelColor
        view.seriesInfoButton.tintColor = Colors.redMarvelColor
        
        view.comicsTitleLabel.font = Fonts.robotoBlack18
        view.storiesTitleLabel.font = Fonts.robotoBlack18
        view.eventsTitleLabel.font = Fonts.robotoBlack18
        view.seriesTitleLabel.font = Fonts.robotoBlack18
        
        view.comicsTitleLabel.textColor = .white
        view.storiesTitleLabel.textColor = .white
        view.eventsTitleLabel.textColor = .white
        view.seriesTitleLabel.textColor = .white
        
        view.comicsTitleLabel.text = "COMMONS_COMICS".localized
        view.storiesTitleLabel.text = "COMMONS_STORIES".localized
        view.eventsTitleLabel.text = "COMMONS_EVENTS".localized
        view.seriesTitleLabel.text = "COMMONS_SERIES".localized
        
        view.comicsNumberLabel.font = Fonts.robotoBlack34
        view.storiesNumberLabel.font = Fonts.robotoBlack34
        view.eventsNumberLabel.font = Fonts.robotoBlack34
        view.seriesNumberLabel.font = Fonts.robotoBlack34
        
        view.comicsNumberLabel.textColor = Colors.darkBackgroundColor
        view.storiesNumberLabel.textColor = Colors.darkBackgroundColor
        view.eventsNumberLabel.textColor = Colors.darkBackgroundColor
        view.seriesNumberLabel.textColor = Colors.darkBackgroundColor
    }
}
