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
            
//            if let data = data {
//                print(String(data: data, encoding: .utf8)!)
//            }
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
}
