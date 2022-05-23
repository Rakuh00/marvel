//
//  SeriesListModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct SeriesListModel: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SeriesSummaryModel]?
}

internal struct SeriesListModelResponse: Decodable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SeriesSummaryModelResponse]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

internal final class SeriesListModelBinding {
    static func bind(_ soaSeriesListModel: SeriesListModelResponse) -> SeriesListModel {
        var seriesListModel = SeriesListModel()
        seriesListModel.available = soaSeriesListModel.available
        seriesListModel.returned = soaSeriesListModel.returned
        seriesListModel.collectionURI = soaSeriesListModel.collectionURI
        
        var itemsArray = [SeriesSummaryModel]()
        if let iArray = soaSeriesListModel.items {
            for item in iArray {
                let itemModel = SeriesSummaryModelBinding.bind(item)
                itemsArray.append(itemModel)
            }
            seriesListModel.items = itemsArray
        }

        return seriesListModel
    }
}
