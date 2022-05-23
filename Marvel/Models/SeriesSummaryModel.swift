//
//  SeriesSummaryModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct SeriesSummaryModel: Codable {
    var resourceURI: String?
    var name: String?
}

internal struct SeriesSummaryModelResponse: Decodable {
    var resourceURI: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

internal final class SeriesSummaryModelBinding {
    static func bind(_ soaSeriesSummaryModel: SeriesSummaryModelResponse) -> SeriesSummaryModel {
        var seriesSummaryModel = SeriesSummaryModel()
        seriesSummaryModel.resourceURI = soaSeriesSummaryModel.resourceURI
        seriesSummaryModel.name = soaSeriesSummaryModel.name

        return seriesSummaryModel
    }
}
