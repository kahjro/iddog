//
//  DogGalleryModel.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import Foundation

struct DogGalleryModel: Codable, Equatable {

    let category: String
    let imageList: [String]

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case imageList = "list"
    }
}
