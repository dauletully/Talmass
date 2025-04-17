//
//  LoginModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 18.03.2025.
//

struct User: Codable {
    let deviceToken: String
    let email: String
    let password: String
}

struct UserResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
}
