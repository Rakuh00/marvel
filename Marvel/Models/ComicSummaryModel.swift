//
//  ComicSummaryModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct ComicSummaryModel: Codable {
    var resourceURI: String?
    var name: String?
}

internal struct ComicSummaryModelResponse: Decodable {
    var resourceURI: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

internal final class ComicSummaryModelBinding {
    static func bind(_ soaComicSummaryModel: ComicSummaryModelResponse) -> ComicSummaryModel {
        var comicSummaryModel = ComicSummaryModel()
        comicSummaryModel.resourceURI = soaComicSummaryModel.resourceURI
        comicSummaryModel.name = soaComicSummaryModel.name

        return comicSummaryModel
    }
}
