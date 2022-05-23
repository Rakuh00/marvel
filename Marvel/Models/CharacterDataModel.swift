//
//  CharacterDataModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct CharacterDataModel: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterModel]?
}

internal struct CharacterDataModelResponse: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterModelResponse]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

internal final class CharacterDataModelBinding {
    static func bind(_ soaCharacterData: CharacterDataModelResponse) -> CharacterDataModel {
        var characterData = CharacterDataModel()
        characterData.offset = soaCharacterData.offset
        characterData.limit = soaCharacterData.limit
        characterData.total = soaCharacterData.total
        characterData.count = soaCharacterData.count
        
        var characterArray = [CharacterModel]()
        if let cArray = soaCharacterData.results {
            for character in cArray {
                let characterModel = CharacterModelBinding.bind(character)
                characterArray.append(characterModel)
            }
            characterData.results = characterArray
        }
        
        return characterData
    }
}
