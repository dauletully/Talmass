//
//  CatalogViewModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//

import UIKit

enum ViewMode {
    case grid
    case list
    case large
}

class CatalogViewModel {
    var products: CatalogModel?
    var onCatalogUpdated: ((CatalogModel) -> Void)?
    var onLayoutChanged: (() -> Void)?
    
    
    var sortOption: SortingOption = .popularity {
        didSet {
            return setProducts()
        }
    }

    func setProducts() {
        switch sortOption {
        case .popularity:
            products?.sort{ $0.id < $1.id }
        case .priceAscending:
            products?.sort{ $0.price < $1.price }
        case .priceDescending:
            products?.sort{ $0.price > $1.price }
        }
        guard let products = products else {fatalError("Products is nil")}
        onCatalogUpdated?(products)
    }
    
    var viewMode: ViewMode = .grid {
        didSet {
            onLayoutChanged?()
        }
    }
    
    func toggleViewMode() {
        switch viewMode {
        case .grid:
            viewMode = .list
        case .list:
            viewMode = .large
        case .large:
            viewMode = .grid
        }
    }

    func fetchCatalog() {
        ApiManager.shared.fetchCatalog { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.onCatalogUpdated?(products)
            case .failure(let error):
                print("Ошибка загрузка каталога: \(error.localizedDescription)")
                
            }
        }
    }
    
    func loadImage(for imageURL: String, complation: @escaping(UIImage?) -> Void) {
        let imageUrl = "http://drevmasstestapi.mobydev.kz/" + imageURL
        ImageLoader.shared.loadImage(from: imageUrl, completion: complation)
    }
}
