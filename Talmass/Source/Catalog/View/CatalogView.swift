//
//  CatalogView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//

import UIKit
import SnapKit

class CatalogView: UIViewController {
    
    public var viewModel = CatalogViewModel()
    public let reuseIdentifier = "CatalogCell"
    private lazy var products: CatalogModel = []
    private var topConstraint: Constraint?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Каталог"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }()

    private lazy var catalogCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 165, height: 180)
        layout.sectionInsetReference = .fromSafeArea
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CatalogCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        
        return collectionView
    }()
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        catalogCollectionView.layer.cornerRadius = 24
        catalogCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        catalogCollectionView.clipsToBounds = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
        setupBinding()
        viewModel.fetchCatalog()
        
    }
    
    private func setupBinding() {
        viewModel.onCatalogUpdated = { [weak self] products in
            self?.products = products
            self?.catalogCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1)
        catalogCollectionView.insetsLayoutMarginsFromSafeArea = true
        view.addSubview(headerLabel)
        view.addSubview(catalogCollectionView)
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(42)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(40)
        }
        
        catalogCollectionView.snp.makeConstraints { make in
            topConstraint = make.top.equalTo(headerLabel.snp.bottom).offset(16).constraint
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension CatalogView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CatalogCell else { return UICollectionViewCell()}
        
        
        cell.configure(with: product, viewModel: viewModel)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let minTop = view.safeAreaInsets.top
        let defaultHeaderTopOffset: CGFloat = 42

        // 🔹 Анимация исчезновения заголовка
        let fadeStart: CGFloat = 20
        let fadeEnd: CGFloat = 100

        if offset < fadeStart {
            headerLabel.alpha = 1.0
        } else if offset > fadeEnd {
            headerLabel.alpha = 0.0
        } else {
            let alpha = 1.0 - ((offset - fadeStart) / (fadeEnd - fadeStart))
            headerLabel.alpha = alpha
        }

        // 🔹 Двигаем `headerLabel` вверх при скролле
        let headerNewTop = max(minTop, defaultHeaderTopOffset - offset)
        headerLabel.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(headerNewTop)
        }

        // 🔹 Двигаем `collectionView` вверх
        if let headerFrame = headerLabel.superview?.convert(headerLabel.frame, to: view) {
            let maxTop = headerFrame.maxY + 16
            let newCollectionTop = max(minTop, maxTop - offset)
            topConstraint?.update(offset: newCollectionTop - maxTop + 16)
        }

        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

}
