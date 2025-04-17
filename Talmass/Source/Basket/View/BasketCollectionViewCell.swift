//
//  BasketCollectionViewCell.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 08.04.2025.
//

import UIKit
import SnapKit

class BasketCollectionViewCell: UICollectionViewCell {
    
    public var onIncreaseProductCount: ((Int) -> Void)?
    public var onDecreaseProductCount: ((Int) -> Void)?
    public var onDeleteProduct: (() -> Void)?
    private var countProduct: Int = 0 {
        didSet {
            self.countLabel.text = "\(countProduct)"
            self.minusButton.isHidden = countProduct == 1
            self.deleteButton.isHidden = countProduct != 1
        }
    }
    
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
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    private let minusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private let countLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))

    private lazy var counterView: UIStackView = {
        let counterView = UIStackView()
        counterView.axis = .horizontal
        counterView.spacing = 8
        counterView.alignment = .center
        counterView.distribution = .equalSpacing
        counterView.backgroundColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1)
        
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.imageView?.contentMode = .scaleAspectFit
        deleteButton.setImage(UIImage(named: "deleteIcon"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        countLabel.textColor = .black
        countLabel.textAlignment = .center
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        counterView.translatesAutoresizingMaskIntoConstraints = false
        
        counterView.addArrangedSubview(minusButton)
        counterView.addArrangedSubview(deleteButton)
        counterView.addArrangedSubview(countLabel)
        counterView.addArrangedSubview(plusButton)
        
        deleteButton.isHidden = true
       
        return counterView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        self.imageView.layer.cornerRadius = 17
        self.imageView.clipsToBounds = true
        
        self.counterView.layer.cornerRadius = 25
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
        addSubview(separatorView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(112)
            make.bottom.equalToSuperview().inset(16)
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
            make.width.equalTo(100)
            make.bottom.equalToSuperview().inset(16)
        }
        counterView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
            make.leading.equalTo(priceLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(1)
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
        
        self.countProduct = product.count
    }
    
    @objc private func minusTapped() {
        self.countProduct -= 1
        self.onDecreaseProductCount?(countProduct)
    }
    
    @objc private func plusTapped() {
        self.countProduct += 1
        self.onIncreaseProductCount?(countProduct)
    }
    
    @objc private func deleteTapped() {
        self.onDeleteProduct?()
    }
    
}
