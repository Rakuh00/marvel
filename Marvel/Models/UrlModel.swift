//
//  UrlModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct UrlModel: Codable {
    var type: String?
    var url: String?
}

internal struct UrlModelResponse: Decodable {
    var type: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
}

internal final class UrlModelBinding {
    static func bind(_ soaUrlModel: UrlModelResponse) -> UrlModel {
        var urlModel = UrlModel()
        urlModel.type = soaUrlModel.type
        urlModel.url = soaUrlModel.url

        return urlModel
    }
}
