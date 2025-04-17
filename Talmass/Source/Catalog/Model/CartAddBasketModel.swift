//
//  CartAddBasketModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 08.04.2025.
//
import UIKit

struct CartAddBasketModel: Codable {
    let count, productID, userID: Int

    enum CodingKeys: String, CodingKey {
        case count
        case productID = "product_id"
        case userID = "user_id"
    }
}

struct UserProfile: Codable {
    let id: Int
    let name, email, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNumber = "phone_number"
    }
}
