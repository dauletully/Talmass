//
//  ApiManager.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.03.2025.
//

import Foundation

class AuthApiManager {
    static let shared = AuthApiManager()
    
    private init() {}
    
    public func registerUser(registrUserRequest: RegisterUser, completion: @escaping (Result<String, Error>) -> Void)  {
        
        guard let url = URL(string: "http://drevmasstestapi.mobydev.kz/api/signup") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let registerData = ["deviceToken": registrUserRequest.deviceToken, "name": registrUserRequest.name, "email": registrUserRequest.email, "password": registrUserRequest.password, "phoneNumber": registrUserRequest.phoneNumber] as [String: Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: registerData)
        } catch {
            completion(.failure(error))
        }
        
        sendRequestData(request, completion: completion)
    }
    
    public func loginUser(loginUserRequest: User, completion: @escaping (Result<String, Error>) -> Void)  {
        
        guard let url = URL(string: "http://drevmasstestapi.mobydev.kz/api/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = ["email": loginUserRequest.email, "password": loginUserRequest.password] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData)
        } catch {
            completion(.failure(error))
        }
        
        sendRequestData(request, completion: completion)
    }
    
    func sendRequestData(_ request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("📩 Ответ сервера: \(jsonString)")
            }
            
            do {
                let authResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                self.saveToken(authResponse.accessToken)
                completion(.success(authResponse.accessToken))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    // MARK: - Сохранение токена
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "accessToken")
    }
    
    // MARK: - Получение токена
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
}
