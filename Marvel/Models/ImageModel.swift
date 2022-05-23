//
//  ImageModel.swift
//  Marvel
//
//  Created by RFG023ES on 21/5/22.
//

import UIKit


internal struct ImageModel: Codable {
    var path: String?
    var extensionImage: String?
}

internal struct ImageModelResponse: Decodable {
    var path: String?
    var extensionImage: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionImage = "extension"
    }
}

internal final class ImageModelBinding {
    static func bind(_ soaImageModel: ImageModelResponse) -> ImageModel {
        var imageModel = ImageModel()
        imageModel.path = soaImageModel.path
        imageModel.extensionImage = soaImageModel.extensionImage

        return imageModel
    }
}
