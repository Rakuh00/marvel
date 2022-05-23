//
//  ListTableViewCell.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit
import AlamofireImage

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var comicsNumberLabel: UILabel!
    @IBOutlet weak var storiesNumberLabel: UILabel!
    @IBOutlet weak var eventsNumberLabel: UILabel!
    @IBOutlet weak var seriesNumberLabel: UILabel!
    @IBOutlet weak var horizontalLineView: UIView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var backgroundButtonView: UIView!
    
    //MARK: Variables
    var delegate: HomeViewController?
    var descriptionText: String?
    
    //MARK: - UITableViewCell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    //MARK: Functions
    func setUpCell() {
        self.contentView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.borderWidth = 2
        cardView.layer.borderColor = Colors.grayLineColor.cgColor
        cardView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = Colors.darkBackgroundColor
        
        characterImageView.layer.borderWidth = 2
        characterImageView.layer.borderColor = Colors.redMarvelColor.cgColor
        
        headerView.backgroundColor = Colors.darkBackgroundColor
        horizontalLineView.backgroundColor = Colors.redMarvelColor
        
        nameLabel.font = Fonts.robotoBlack20
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.textColor = .white
        
        comicsNumberLabel.font = Fonts.robotoBold17
        comicsNumberLabel.adjustsFontSizeToFitWidth = true
        comicsNumberLabel.minimumScaleFactor = 0.5
        comicsNumberLabel.textColor = .gray
        storiesNumberLabel.font = Fonts.robotoBold17
        storiesNumberLabel.adjustsFontSizeToFitWidth = true
        storiesNumberLabel.minimumScaleFactor = 0.5
        storiesNumberLabel.textColor = .gray
        eventsNumberLabel.font = Fonts.robotoBold17
        eventsNumberLabel.adjustsFontSizeToFitWidth = true
        eventsNumberLabel.minimumScaleFactor = 0.5
        eventsNumberLabel.textColor = .gray
        seriesNumberLabel.font = Fonts.robotoBold17
        seriesNumberLabel.adjustsFontSizeToFitWidth = true
        seriesNumberLabel.minimumScaleFactor = 0.5
        seriesNumberLabel.textColor = .gray
        
        buttonImageView.image = UIImage(named: "info_icon_marvel")
        buttonImageView.image = buttonImageView.image?.withRenderingMode(.alwaysTemplate)
        buttonImageView.tintColor = .white
        backgroundButtonView.backgroundColor = Colors.redMarvelColor
        descriptionButton.backgroundColor = .clear
        descriptionButton.titleLabel?.font = Fonts.robotoBlack18
        descriptionButton.setTitle("", for: .normal)
    }
    
    func setInfo(character: CharacterModel) {
        nameLabel.text = character.name?.uppercased()
        comicsNumberLabel.text = "\("COMMONS_COMICS".localized): \(String(character.comics?.available ?? 0))"
        storiesNumberLabel.text = "\("COMMONS_STORIES".localized): \(String(character.stories?.available ?? 0))"
        eventsNumberLabel.text = "\("COMMONS_EVENTS".localized): \(String(character.events?.available ?? 0))"
        seriesNumberLabel.text = "\("COMMONS_SERIES".localized): \(String(character.series?.available ?? 0))"
        
        setImage(character: character)
    }
    
    func setImage(character: CharacterModel) {
        if let charThumbnail = character.thumbnail, let extensionImage = character.thumbnail?.extensionImage {
            if let url = URL(string: "\(charThumbnail.path ?? "").\(extensionImage)") {
                self.characterImageView.af_setImage(withURL: url)
            } else {
                characterImageView.image = UIImage()
            }
        }
    }
    
    //MARK: Actions
    @IBAction func descriptionAction(_ sender: Any) {
        if let homeDelegate = delegate, let text = descriptionText {
            homeDelegate.goToDescriptionScreen(text: text)
        }
    }
}
