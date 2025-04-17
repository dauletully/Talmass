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
    var onProductsChanged: ((BasketModel?) -> Void)?
    var onGoToTapped: (() -> Void)?
    var onPriceChanged: ((Int) -> Void)?
    var onEmpty: (() -> Bool)?
    var onOrderTapped: (() -> Void)?
    
    var totalPrice: Int = 0 {
        didSet {
            onPriceChanged?(totalPrice)
        }
    }
    
    init() {
        BasketManager.shared.onBasketChanged = { [weak self] updatedProducts in
            self?.products = updatedProducts
            self?.onProductsChanged?(updatedProducts)
            self?.totalPrice = self?.products?.totalPrice ?? 0
        }
    }

    func fetchBasket() {
        ApiManager.shared.fetchBasket { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let basketCatalog):
                    self.products = basketCatalog
                    self.onProductsChanged?(basketCatalog)
                    self.totalPrice = self.products?.totalPrice ?? 0
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func increaseCount(for product: BasketItemModel, count: Int) {
        let userID = ApiManager.shared.getUserID()
        print("Increase \(userID), \(product.productID), \(count)")
        ApiManager.shared.increaseCartToBasket(productID: product.productID, count: count, userID: userID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    print("Successfully increased to basket")
                case .failure(let error):
                    print("Error adding to basket: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func decreaseCount(for product: BasketItemModel, count: Int) {
        let userID = ApiManager.shared.getUserID()
        print("Decrease \(userID), \(product.productID), \(count)")
        ApiManager.shared.decreaseCartToBasket(productID: product.productID, count: count, userID: userID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    print("Successfully decreased to basket")
                case .failure(let error):
                    print("Error adding to basket: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteProduct(fromBasket product: BasketItemModel) {
        print("Delete \(product.productID)")
        ApiManager.shared.deleteCartToBasket(productID: product.productID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(()):
                    print("Successfully deleted from basket")
                    BasketManager.shared.updateBasket()
                case .failure(let error):
                    print("Error deleting from basket: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadImage(for imageURL: String, complation: @escaping(UIImage?) -> Void) {
        let imageUrl = "http://drevmasstestapi.mobydev.kz/" + imageURL
        ImageLoader.shared.loadImage(from: imageUrl, completion: complation)
    }
    
}
