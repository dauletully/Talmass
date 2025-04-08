//
//  BasketViewModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 07.04.2025.
//
import UIKit

class BasketViewModel {
    var products: BasketModel?
    var bonus: Int?
    var totalPrice: Int?
    
    var onEmpty: (() -> Bool)?
    
    func fetchBasket(completion: @escaping () -> Void) {
        ApiManager.shared.fetchBasket { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let basketCatalog):
                    self.products = basketCatalog
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadImage(for imageURL: String, complation: @escaping(UIImage?) -> Void) {
        let imageUrl = "http://drevmasstestapi.mobydev.kz/" + imageURL
        ImageLoader.shared.loadImage(from: imageUrl, completion: complation)
    }
    
}
