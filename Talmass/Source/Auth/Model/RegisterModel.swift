import Foundation

struct RegisterUser: Codable {
    let deviceToken: String
    let email: String
    let name: String
    let password: String
    let phoneNumber: String
}

struct RegisterResponse: Codable {
    let message: String
}

