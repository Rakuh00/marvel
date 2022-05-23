//
//  StorySummaryModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct StorySummaryModel: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?
}

internal struct StorySummaryModelResponse: Decodable {
    var resourceURI: String?
    var name: String?
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case type
    }
}

internal final class StorySummaryModelBinding {
    static func bind(_ soaStorySummaryModel: StorySummaryModelResponse) -> StorySummaryModel {
        var storySummaryModel = StorySummaryModel()
        storySummaryModel.resourceURI = soaStorySummaryModel.resourceURI
        storySummaryModel.name = soaStorySummaryModel.name
        storySummaryModel.type = soaStorySummaryModel.type

        return storySummaryModel
    }
}
