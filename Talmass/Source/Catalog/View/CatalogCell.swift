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
        label.font = .systemFont(ofSize: 15, weight: .bold)
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
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
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
        addSubview(separatorView)
        
    }
    
    private func setupGridLayout() {
        imageView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        activityIndicator.snp.remakeConstraints { make in
            make.center.equalTo(imageView)
        }
        
        priceLabel.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
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
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.trailing.equalTo(contentView)
            make.height.width.equalTo(36)
        }
    }
    
    private func setupListLayout() {
        imageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.height.equalTo(88)
            make.width.equalTo(100).priority(.low)
        }
        activityIndicator.snp.remakeConstraints { make in
            make.center.equalTo(imageView)
        }
        nameLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualToSuperview()
            make.width.equalTo(186).priority(.high)
            make.height.equalTo(40)
        }
        self.priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.snp.remakeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.width.equalTo(137)
            make.height.equalTo(20)
        }
        buyButton.snp.remakeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(36)
        }
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupLargeLayout() {
        imageView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(202)
        }
        activityIndicator.snp.remakeConstraints { make in
            make.center.equalTo(imageView)
        }
        self.priceLabel.font = .systemFont(ofSize: 20, weight: .bold)
        priceLabel.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(279).priority(.high)
        }
        nameLabel.snp.remakeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalTo(buyButton.snp.leading).offset(-16)
            make.height.equalTo(22)
        }
        buyButton.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(48).priority(.high)
        }
        
    }
    
    public func applyLayout(mode: ViewMode) {
        separatorView.isHidden = (mode != .list)
        switch mode {
        case .grid:
            setupGridLayout()
        case .large:
            setupLargeLayout()
        case .list:
            setupListLayout()
        }
        
        setNeedsLayout()
        layoutIfNeeded()
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
        
        applyLayout(mode: viewModel.viewMode)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Удаляем все старые `constraints`
        imageView.snp.removeConstraints()
        priceLabel.snp.removeConstraints()
        nameLabel.snp.removeConstraints()
        buyButton.snp.removeConstraints()
        activityIndicator.snp.removeConstraints()
    }
}

