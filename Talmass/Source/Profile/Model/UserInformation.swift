//
//  UserInformation.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.04.2025.
//

struct UserInformationModel: Codable {
    let activity: Int
    let birth, email: String
    let gender, height, id: Int
    let name, phoneNumber: String
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case activity, birth, email, gender, height, id, name
        case phoneNumber = "phone_number"
        case weight
    }
}

struct UserInformationResponse: Codable {
    let data: UserInformationModel
}
