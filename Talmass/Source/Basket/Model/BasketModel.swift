//
//  BasketModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 07.04.2025.
//
import UIKit

//MARK: - Basket
struct BasketItemModel: Codable {
    let count, price, productID: Int
    let productImg, productTitle: String

    enum CodingKeys: String, CodingKey {
        case count, price
        case productID = "product_id"
        case productImg = "product_img"
        case productTitle = "product_title"
    }
}

//MARK: - Basket response
struct BasketModel: Codable {
    let basket: [BasketItemModel]
        let basketPrice, bonus, countProducts, discount: Int
        let products: CatalogModel
        let totalPrice, usedBonus: Int

        enum CodingKeys: String, CodingKey {
            case basket
            case basketPrice = "basket_price"
            case bonus
            case countProducts = "count_products"
            case discount, products
            case totalPrice = "total_price"
            case usedBonus = "used_bonus"
        }
}


