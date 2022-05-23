//
//  ComicListModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct ComicListModel: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicSummaryModel]?
}

internal struct ComicListModelResponse: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicSummaryModelResponse]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

internal final class ComicListModelBinding {
    static func bind(_ soaComicListModel: ComicListModelResponse) -> ComicListModel {
        var comicListModel = ComicListModel()
        comicListModel.available = soaComicListModel.available
        comicListModel.returned = soaComicListModel.returned
        comicListModel.collectionURI = soaComicListModel.collectionURI
        
        var itemsArray = [ComicSummaryModel]()
        if let iArray = soaComicListModel.items {
            for item in iArray {
                let itemModel = ComicSummaryModelBinding.bind(item)
                itemsArray.append(itemModel)
            }
            comicListModel.items = itemsArray
        }

        return comicListModel
    }
}
