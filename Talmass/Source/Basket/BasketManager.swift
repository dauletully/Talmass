//
//  BasketManager.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 11.04.2025.
//
import UIKit

class BasketManager {
    static let shared = BasketManager()
    
    private(set) var basket: BasketModel? {
        didSet {
            onBasketChanged?(basket)
        }
    }
    
    var onBasketChanged: ((BasketModel?) -> Void)?
    
    func updateBasket(completion: (() -> Void)? = nil) {
        ApiManager.shared.fetchBasket { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let basket):
                    self.basket = basket
                case .failure(let error):
                    print("Basket fetch error: \(error)")
                }
                completion?()
            }
        }
    }
    
    
}
