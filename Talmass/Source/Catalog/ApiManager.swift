//
//  ApiManager.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//
import UIKit

class ApiManager {
    static let shared = ApiManager()
    init() {}
    
    private let baseUrl = URL(string: "http://drevmasstestapi.mobydev.kz/api/")!
    let token = AuthApiManager.shared.getToken() ?? ""
    
    func fetchCatalog(complation: @escaping (Result<CatalogModel, Error>) -> Void){
        guard let url = URL(string: "products", relativeTo: baseUrl) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQm9zcyIsImlkIjo5MjZ9.-XMwNa6tD70GYbXOVMZ8I1zafpoLZjRuSo7mn3cfMIA", forHTTPHeaderField: "Authorization" )
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complation(.failure(error))
            }
            
            if let data = data {
                do {
                    let catalogModel = try JSONDecoder().decode(CatalogModel.self, from: data)
                    DispatchQueue.main.async {
                        complation(.success(catalogModel))
                    }
                   
                } catch {
                    complation(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func addCartToBasket(productID: Int, count: Int, userID: Int, complation: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "basket", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        
       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Barear \(token)", forHTTPHeaderField: "Authorization")
        
        let sendData = CartAddBasketModel(count: count, productID: productID, userID: userID)
        
        
        request.httpBody = try? JSONEncoder().encode(sendData)
        
        requestSession(request: request, completion: complation)
    }
    
    func increaseCartToBasket(productID: Int, count: Int, userID: Int, complation: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "increase", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Barear \(token)", forHTTPHeaderField: "Authorization")
        
        let sendData = CartAddBasketModel(count: count, productID: productID, userID: userID)
        
        request.httpBody = try? JSONEncoder().encode(sendData)
        
        requestSession(request: request, completion: complation)
    }
    
    func decreaseCartToBasket(productID: Int, count: Int, userID: Int, complation: @escaping (Result<Void, Error>) -> Void) {
        
        guard let url = URL(string: "decrease", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Barear \(token)", forHTTPHeaderField: "Authorization")
        
        let sendData = CartAddBasketModel(count: count, productID: productID, userID: userID)
        
        request.httpBody = try? JSONEncoder().encode(sendData)
        
       requestSession(request: request, completion: complation)
    }
    
    func deleteCartToBasket(productID: Int, complation: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "basket/\(productID)", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Barear \(token)", forHTTPHeaderField: "Authorization")
        
        requestSession(request: request, completion: complation)
    }
    
    func requestSession(request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
        task.resume()
    }
    
    func getUserID() -> Int {
        guard let url = URL(string: "user", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        var userId = Int()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print(data)
            if let user = try? JSONDecoder().decode(UserProfile.self, from: data) {
                //                UserDefaults.standard.set(user.id, forKey: "user_id")
                userId = user.id
            }
        }
        task.resume()
        return userId
    }
    
    
    func fetchBasket(completion: @escaping (Result<BasketModel, Error>) -> Void) {
        guard let url = URL(string: "basket", relativeTo: baseUrl) else {fatalError("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQm9zcyIsImlkIjo5MjZ9.-XMwNa6tD70GYbXOVMZ8I1zafpoLZjRuSo7mn3cfMIA", forHTTPHeaderField: "Authorization" )
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let basket = try JSONDecoder().decode(BasketModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(basket))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
