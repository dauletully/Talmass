//
//  ApiManager.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.03.2025.
//

import Foundation

class ApiManager {
  static let shared = ApiManager()
    
    private init() {}
    
    public func registerUser(registrUserRequest: RegisterUser, completion: @escaping (Result<Void, Error>) -> Void)  {
        
        guard let url = URL(string: "http://drevmasstestapi.mobydev.kz/api/signup") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jSONData = try JSONEncoder().encode(registrUserRequest)
            request.httpBody = jSONData
        } catch {
            completion(.failure(error))
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
            
        }.resume()
        
        
        
    }
}
