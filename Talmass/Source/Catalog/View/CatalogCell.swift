//
//  CatalogCell.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//
import UIKit
import SnapKit

class CatalogCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
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
        label.textColor = .black
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buyButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(activityIndicator)
        addSubview(priceLabel)
        addSubview(nameLabel)
        addSubview(buyButton)
        
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(117)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalTo(buyButton.snp.leading).offset(-12)
            make.height.equalTo(45)
        }
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.trailing.equalTo(contentView)
            make.height.width.equalTo(36)
        }
    }
    
    public func configure(with product: Product, viewModel: CatalogViewModel) {
        if imageView.image == nil {
            self.activityIndicator.startAnimating()
        }
        
        viewModel.loadImage(for: product.imageSrc) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
        self.priceLabel.text = String(product.price) + " ₽"
        self.nameLabel.text = product.title
    }
}

