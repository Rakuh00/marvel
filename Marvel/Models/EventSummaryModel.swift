//
//  EventSummaryModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct EventSummaryModel: Codable {
    var resourceURI: String?
    var name: String?
}

internal struct EventSummaryModelResponse: Decodable {
    var resourceURI: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
    }
}

internal final class EventSummaryModelBinding {
    static func bind(_ soaEventSummaryModel: EventSummaryModelResponse) -> EventSummaryModel {
        var eventSummaryModel = EventSummaryModel()
        eventSummaryModel.resourceURI = soaEventSummaryModel.resourceURI
        eventSummaryModel.name = soaEventSummaryModel.name

        return eventSummaryModel
    }
}
