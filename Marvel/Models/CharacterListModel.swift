//
//  CharacterListModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit

internal struct CharacterListModel: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var atttibutionText: String?
    var data: CharacterDataModel?
    var etag: String?
}

internal struct CharacterListModelResponse: Decodable {
    var code: Int?
    var status: String?
    var copyright: String?
    var atttibutionText: String?
    var data: CharacterDataModelResponse?
    var etag: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case atttibutionText
        case data
        case etag
    }
}

internal final class CharacterListModelBinding {
    static func bind(_ soaCharacterList: CharacterListModelResponse) -> CharacterListModel {
        var characterList = CharacterListModel()
        characterList.code = soaCharacterList.code
        characterList.status = soaCharacterList.status
        characterList.copyright = soaCharacterList.copyright
        characterList.atttibutionText = soaCharacterList.atttibutionText
        characterList.etag = soaCharacterList.etag
        
        if let charData = soaCharacterList.data {
            characterList.data = CharacterDataModelBinding.bind(charData)
        }
        
        return characterList
    }
}
