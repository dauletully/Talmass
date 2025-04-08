//
//  BasketCollectionViewCell.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 08.04.2025.
//

import UIKit
import SnapKit

class BasketCollectionViewCell: UICollectionViewCell {
    
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
    
    private let minusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))

    private lazy var counterView: UIStackView = {
        let counterView = UIStackView()
        counterView.axis = .horizontal
        counterView.spacing = 8
        counterView.alignment = .center
        counterView.backgroundColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1)
        
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        
        countLabel.text = "1"
        countLabel.textColor = .black
        countLabel.textAlignment = .center
        
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        
        counterView.addArrangedSubview(minusButton)
        counterView.addArrangedSubview(countLabel)
        counterView.addArrangedSubview(plusButton)
       
        return counterView
    }()
    
    override func layoutSubviews() {
        self.counterView.layer.cornerRadius = 15
        self.counterView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIfNeeded()
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(counterView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.width.equalTo(111)
            make.bottom.equalToSuperview()
        }
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func configure(product: BasketItemModel, viewModel: BasketViewModel) {
        if self.imageView.image != nil {
            self.activityIndicator.startAnimating()
        }
        viewModel.loadImage(for: product.productImg) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
        self.nameLabel.text = product.productTitle
        self.priceLabel.text = "\(product.price) ₽"
        self.countLabel.text = "\(product.count)"
    }
    
    @objc private func minusTapped() {
        
    }
    
    @objc private func plusTapped() {
        
    }
    
    
}
