//
//  DetailViewController.swift
//  Marvel
//
//  Created by RFG023ES on 22/5/22.
//

import UIKit
import Motion

internal final class DetailViewController: UIViewController {
    
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var storiesView: UIView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var seriesView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var comicsTitleView: UIView!
    @IBOutlet weak var comicsInfoButton: UIButton!
    @IBOutlet weak var comicsTitleLabel: UILabel!
    @IBOutlet weak var comicsNumberLabel: UILabel!
    @IBOutlet weak var storiesTitleView: UIView!
    @IBOutlet weak var storiesInfoButton: UIButton!
    @IBOutlet weak var storiesTitleLabel: UILabel!
    @IBOutlet weak var storiesNumberLabel: UILabel!
    @IBOutlet weak var eventsTitleView: UIView!
    @IBOutlet weak var eventsInfoButton: UIButton!
    @IBOutlet weak var eventsTitleLabel: UILabel!
    @IBOutlet weak var eventsNumberLabel: UILabel!
    @IBOutlet weak var seriesTitleView: UIView!
    @IBOutlet weak var seriesInfoButton: UIButton!
    @IBOutlet weak var seriesTitleLabel: UILabel!
    @IBOutlet weak var seriesNumberLabel: UILabel!
    
    
    //MARK: - VIPER dependencies
    var presenter: DetailPresenterInterface!
    
    //MARK: Variables
    var characterId: Int?
    var motionId: String?
    var constructorLoadingLottie: ConstructorLoading?
    var characterModel: CharacterModel?

    //MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        isMotionEnabled = true
        if let motion = motionId {
            modalView.motionIdentifier = motion
        }
        presenter.setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let id = characterId {
            startLoadingLottie()
            presenter.getDetailCharacter(characterId: id, view: self)
        }
    }
    
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func comicsInfoAction(_ sender: Any) {
        if let character = characterModel {
            var arrayComics = [String]()
            if let comics = character.comics?.items {
                for comic in comics {
                    arrayComics.append(comic.name ?? "")
                }
                presenter.goToModalListScreen(type: .comic, arrayList: arrayComics)
            }
        }
    }
    
    @IBAction func storiesInfoAction(_ sender: Any) {
        if let character = characterModel {
            var arrayStories = [String]()
            if let stories = character.stories?.items {
                for story in stories {
                    arrayStories.append(story.name ?? "")
                }
                presenter.goToModalListScreen(type: .story, arrayList: arrayStories)
            }
        }
    }
    
    @IBAction func eventsInfoAction(_ sender: Any) {
        if let character = characterModel {
            var arrayEvents = [String]()
            if let events = character.events?.items {
                for event in events {
                    arrayEvents.append(event.name ?? "")
                }
                presenter.goToModalListScreen(type: .event, arrayList: arrayEvents)
            }
        }
    }
    
    @IBAction func seriesInfoAction(_ sender: Any) {
        if let character = characterModel {
            var arraySeries = [String]()
            if let series = character.series?.items {
                for serie in series {
                    arraySeries.append(serie.name ?? "")
                }
                presenter.goToModalListScreen(type: .serie, arrayList: arraySeries)
            }
        }
    }
}

//MARK: - ViewInterface Protocol
extension DetailViewController: DetailViewInterface {
    func startLoadingLottie() {
        constructorLoadingLottie = ConstructorLoading(frame: self.view.frame)
        constructorLoadingLottie?.showLoading(originViewController: self)
    }
    
    func stopLoadingLottie() {
        constructorLoadingLottie?.stopLoading()
    }
    
    func showModalView() {
        UIView.animate(withDuration: 0.3) {
            self.modalView.alpha = 1
        }
    }
    
    func showError(textError: String) {
        stopLoadingLottie()
        presenter.router.goToAlertScreen(textError: textError)
    }
}
