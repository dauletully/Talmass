//
//  UserModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 18.04.2025.
//

struct UserModel: Codable {
    let id: Int
    let name, email, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case phoneNumber = "phone_number"
    }
}
