//
//  CardView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 28.03.2025.
//

import UIKit
import SnapKit

class CardView: UIViewController {
    
    private var bottomConstraint: Constraint?
    private var cardSpecsView = CardSpecsView()
    private let identifier: String = "RecomentGoodCollectionViewIdentifier"
    private lazy var recomendProducts = CatalogModel()
    private var viewModel: CatalogViewModel?
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = true
        
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var basketButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.backgroundColor = UIColor(red: 181/255, green: 153/255, blue: 128/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Как использовать?", for: .normal)
        button.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        button.setImage(UIImage(systemName: "video"), for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var recomendTextLabel: UILabel = {
        let label = UILabel()
        label.text = "С этими товарами покупают"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 165, height: 180)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecomentGoodCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        return collectionView
    }()

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        self.basketButton.layer.cornerRadius = 35
        self.basketButton.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(basketButton)
        view.addSubview(videoButton)
        view.addSubview(cardSpecsView)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextLabel)
        view.addSubview(recomendTextLabel)
        view.addSubview(collectionView)
        
       
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(collectionView.snp.bottom).offset(20)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(222)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(22)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(34)
        }
        basketButton.snp.makeConstraints { make in
            make.bottom.equalTo(videoButton.snp.top).offset(-5)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(56)
        }
        videoButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(76)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        cardSpecsView.snp.makeConstraints { make in
            make.top.equalTo(videoButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(120)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cardSpecsView.snp.bottom).offset(32)
            make.trailing.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.trailing.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        recomendTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextLabel.snp.bottom).offset(32)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recomendTextLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
    }
    
    public func configureCard(with product: Product, for viewModel: CatalogViewModel, recomendCatalog: CatalogModel) {
        if self.imageView.image != nil {
            self.activityIndicator.startAnimating()
        }
        viewModel.loadImage(for: product.imageSrc) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
        self.titleLabel.text = product.title
        self.priceLabel.text = "\(product.price) ₽"
        self.cardSpecsView.configure(size: product.size, height: product.height.rawValue)
        self.descriptionTextLabel.text = product.description
        
        self.viewModel = viewModel
        
        getRecomendProducts(catalog: recomendCatalog, product: product)
       
    }
    
    private func getRecomendProducts(catalog: CatalogModel, product: Product) {
        let productName = product.title.first
        
        for item in catalog {
            if item.title.first == productName {
                self.recomendProducts.append(item)
            }
        }
        
    }
    
}

extension CardView: UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recomendProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? RecomentGoodCollectionViewCell else {fatalError()}
        
        cell.configureCell(product: recomendProducts[indexPath.row], viewModel: self.viewModel)
        
        return cell
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // 🔹 Анимация появления / исчезновения кнопки
        let fadeStart: CGFloat = 250
        let fadeEnd: CGFloat = 400
        
        if offset < fadeStart {
            basketButton.alpha = 1.0
        } else if offset > fadeEnd {
            basketButton.alpha = 0.0
        } else {
            let alpha = 1.0 - ((offset - fadeStart) / (fadeEnd - fadeStart))
            basketButton.alpha = alpha
        }
        
        let shouldShowTitle = offset > 270
        
        UIView.animate(withDuration: 0.2) {
            self.title = shouldShowTitle ? self.titleLabel.text : ""
            self.basketButton.alpha = 1.0
            self.view.layoutIfNeeded()
            
        }
        
    }
}
