import Foundation

struct RegisterUser: Codable {
    let devicaToken: String
    let email: String
    let name: String
    let password: String
    let phoneNumber: String
}

struct RegisterResponse: Codable {
    let token: String
    let user: RegisterUser
}

