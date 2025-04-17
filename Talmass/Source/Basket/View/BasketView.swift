//
//  BasketView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 08.04.2025.
//

import UIKit
import SnapKit

class BasketView: UIViewController {
    
    private let viewModel: BasketViewModel
    private var basketCatalog:  BasketModel?
    private lazy var bonusView = BonusView()
    private lazy var summaryView = SummaryView()
    private lazy var usedBonusCount: Int = 0
    
    
    private let identifier: String = "BasketProductCollectionViewCell"
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Каталог"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var basketProductCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 343, height: 108)
        layout.scrollDirection = .vertical
        layout.sectionInsetReference = .fromSafeArea
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
        imageView.image = UIImage(named: "emptyBasketIcon")
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 263, height: 22))
        titleLabel.text = "В корзине пока ничего нет"
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 263, height: 46))
        subtitleLabel.text = "Наполните её товарами из каталога"
        
        let button = UIButton(type: .system)
        button.setTitle("Перейти в каталог", for: .normal)
        button.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(goToCatalogTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, subtitleLabel, button])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(200)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(goToPaymentTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.contentView.layer.cornerRadius = 24
        self.contentView.clipsToBounds = true
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.emptyView.layer.cornerRadius = 24
        self.emptyView.clipsToBounds = true
        self.emptyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.orderButton.layer.cornerRadius = 24
        self.orderButton.clipsToBounds = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
        setupBinding()
        
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.fetchBasket()
        }
        
    }
    
    private func setupBinding() {
        viewModel.onProductsChanged = { [weak self] products in
            self?.basketCatalog = products
            self?.basketProductCollectionView.reloadData()
            
            self?.bonusView.configureBonusView(bonusAmount: self?.basketCatalog?.bonus)
            self?.summaryView.configure(itemCount: self?.basketCatalog?.countProducts ?? 0, bonus: self?.usedBonusCount ?? 0, total: self?.basketCatalog?.totalPrice ?? 0)
            
            self?.updateUI()
        }
        
        viewModel.onPriceChanged = { [weak self] price in
            let formatted = price.formattedWithSeparator()
            self?.orderButton.setTitle("Оформить  \(formatted) ₽", for: .normal)
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1)
        view.addSubview(headerLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(emptyView)
        contentView.addSubview(basketProductCollectionView)
        contentView.addSubview(bonusView)
        contentView.addSubview(summaryView)
        contentView.addSubview(orderButton)
        
    }
    
    private func updateUI() {
        var isEmpty = Bool()
        if self.basketCatalog?.countProducts == 0 {
            isEmpty = true
        } else {
            isEmpty = false
        }
        emptyView.isHidden = !isEmpty
        contentView.isHidden = isEmpty
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(48)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(40)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(summaryView.snp.bottom).offset(20)
        }
        basketProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(250)
        }
        bonusView.snp.makeConstraints { make in
            make.top.equalTo(basketProductCollectionView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(155)
        }
        summaryView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(134)
        }
        orderButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(56)
        }
        
    }
    @objc private func goToCatalogTapped() {
        self.viewModel.onGoToTapped?()
    }
    @objc private func goToPaymentTapped() {
        self.viewModel.onOrderTapped?()
    }
}

extension BasketView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.basketCatalog?.countProducts ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.basketCatalog?.basket[indexPath.row] else { fatalError("There is no product")}
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BasketCollectionViewCell else {return BasketCollectionViewCell()}
        
        cell.configure(product: item, viewModel: self.viewModel)
        
        cell.onIncreaseProductCount = { [weak self] newCount in
            self?.viewModel.increaseCount(for: item, count: newCount)
            
        }
        
        cell.onDecreaseProductCount = { [weak self] newCount in
            self?.viewModel.decreaseCount(for: item, count: newCount)
        }
        
        cell.onDeleteProduct = { [weak self] in
            self?.viewModel.deleteProduct(fromBasket: item)
        }
        
        return cell
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
