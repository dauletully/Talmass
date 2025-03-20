//
//  CatalogModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let height: Height
    let size: String
    let basketCount: Int
    let imageSrc, videoSrc: String

    enum CodingKeys: String, CodingKey {
        case id, title, description, price, height, size
        case basketCount = "basket_count"
        case imageSrc = "image_src"
        case videoSrc = "video_src"
    }
}
enum Height: String, Codable {
    case the181205См = "181-205 см"
    case выше205См = "выше 205 см"
    case дляВсех = "для всех"
    case до180См = "до 180 см"
}

typealias CatalogModel = [Product]
