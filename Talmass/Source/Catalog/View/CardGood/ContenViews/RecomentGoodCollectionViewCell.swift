//
//  RecomentGoodCollectionViewCell.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 04.04.2025.
//

import UIKit
import SnapKit

class RecomentGoodCollectionViewCell: UICollectionViewCell {
    
    private lazy var layoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buyButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        
        return button
    }()
    
    override func layoutSubviews() {
        self.layoutImageView.layer.cornerRadius = 10
        self.layoutImageView.clipsToBounds = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(layoutImageView)
        addSubview(priceLabel)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        layoutImageView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        activityIndicator.snp.remakeConstraints { make in
            make.center.equalTo(layoutImageView)
        }
        
        priceLabel.snp.remakeConstraints { make in
            make.top.equalTo(layoutImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(117)
        }
        
        nameLabel.snp.remakeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalTo(buyButton.snp.leading).offset(-12)
            make.height.equalTo(45)
        }
        
        buyButton.snp.remakeConstraints { make in
            make.top.equalTo(layoutImageView.snp.bottom).offset(12)
            make.trailing.equalTo(contentView)
            make.height.width.equalTo(36)
        }
    }
    public func configureCell(product: Product, viewModel: CatalogViewModel?) {
        
        if layoutImageView.image == nil {
            self.activityIndicator.startAnimating()
        }
        
        viewModel?.loadImage(for: product.imageSrc) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.layoutImageView.image = image
        }
        self.priceLabel.text = "\(product.price) ₽"
        self.nameLabel.text = product.title
        
    }
}
