//
//  CharacterModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct CharacterModel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [UrlModel]?
    var thumbnail: ImageModel?
    var comics: ComicListModel?
    var stories: StoryListModel?
    var events: EventListModel?
    var series: SeriesListModel?
}

internal struct CharacterModelResponse: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [UrlModelResponse]?
    var thumbnail: ImageModelResponse?
    var comics: ComicListModelResponse?
    var stories: StoryListModelResponse?
    var events: EventListModelResponse?
    var series: SeriesListModelResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceURI
        case urls
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
}

internal final class CharacterModelBinding {
    static func bind(_ soaCharacter: CharacterModelResponse) -> CharacterModel {
        var character = CharacterModel()
        character.id = soaCharacter.id
        character.name = soaCharacter.name
        
        var descriptionText = "COMMONS_NOT_AVAILABLE".localized
        if soaCharacter.description != nil && soaCharacter.description != "" {
            descriptionText = soaCharacter.description!
        }
        
        character.description = descriptionText
        character.modified = soaCharacter.modified
        character.resourceURI = soaCharacter.resourceURI
        
        var urlsArray = [UrlModel]()
        if let uArray = soaCharacter.urls {
            for url in uArray {
                let urlModel = UrlModelBinding.bind(url)
                urlsArray.append(urlModel)
            }
            character.urls = urlsArray
        }
        
        if let charThumbnail = soaCharacter.thumbnail {
            character.thumbnail = ImageModelBinding.bind(charThumbnail)
        }
        
        if let charComics = soaCharacter.comics {
            character.comics = ComicListModelBinding.bind(charComics)
        }
        
        if let charStories = soaCharacter.stories {
            character.stories = StoryListModelBinding.bind(charStories)
        }
        
        if let charEvents = soaCharacter.events {
            character.events = EventListModelBinding.bind(charEvents)
        }
        
        if let charSeries = soaCharacter.series {
            character.series = SeriesListModelBinding.bind(charSeries)
        }
        
        return character
    }
}
