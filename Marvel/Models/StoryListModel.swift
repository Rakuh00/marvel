//
//  StoryListModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct StoryListModel: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummaryModel]?
}

internal struct StoryListModelResponse: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummaryModelResponse]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

internal final class StoryListModelBinding {
    static func bind(_ soaStoryListModel: StoryListModelResponse) -> StoryListModel {
        var storyListModel = StoryListModel()
        storyListModel.available = soaStoryListModel.available
        storyListModel.returned = soaStoryListModel.returned
        storyListModel.collectionURI = soaStoryListModel.collectionURI
        
        var itemsArray = [StorySummaryModel]()
        if let iArray = soaStoryListModel.items {
            for item in iArray {
                let itemModel = StorySummaryModelBinding.bind(item)
                itemsArray.append(itemModel)
            }
            storyListModel.items = itemsArray
        }

        return storyListModel
    }
}
