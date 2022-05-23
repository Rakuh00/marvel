//
//  EventListModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct EventListModel: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventSummaryModel]?
}

internal struct EventListModelResponse: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventSummaryModelResponse]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

internal final class EventListModelBinding {
    static func bind(_ soaEventListModel: EventListModelResponse) -> EventListModel {
        var eventListModel = EventListModel()
        eventListModel.available = soaEventListModel.available
        eventListModel.returned = soaEventListModel.returned
        eventListModel.collectionURI = soaEventListModel.collectionURI
        
        var itemsArray = [EventSummaryModel]()
        if let iArray = soaEventListModel.items {
            for item in iArray {
                let itemModel = EventSummaryModelBinding.bind(item)
                itemsArray.append(itemModel)
            }
            eventListModel.items = itemsArray
        }

        return eventListModel
    }
}
