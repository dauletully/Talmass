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
    private var topConstraintView: Constraint?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Каталог"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var layoutToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "grid_type"), for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(toggleView), for: .touchUpInside)
        
        return button
    }()
    
    private var layoutSortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sort_price_ascending"), for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(sortView), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sortTitle: UILabel = {
        let title = UILabel()
        title.text = "По популярности"
        title.font = .systemFont(ofSize: 15, weight: .medium)
        title.textColor = .black
        title.textAlignment = .left
        
        return title
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        
        return view
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
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        buttonView.clipsToBounds = true
        buttonView.layer.cornerRadius = 24
        buttonView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
        
        viewModel.onLayoutChanged = { [weak self] in
            guard let self = self else { return }
            self.catalogCollectionView.reloadData()
            self.updateCollectionViewLayout()
            
            self.catalogCollectionView.reloadData()
        }
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1)
        catalogCollectionView.insetsLayoutMarginsFromSafeArea = true
        view.addSubview(headerLabel)
        view.addSubview(buttonView)
        buttonView.addSubview(layoutToggleButton)
        buttonView.addSubview(layoutSortButton)
        buttonView.addSubview(sortTitle)
        view.addSubview(catalogCollectionView)
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(42)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(40)
        }
        buttonView.snp.makeConstraints { make in
            topConstraintView = make.top.equalTo(headerLabel.snp.bottom).offset(16).constraint
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(52)
        }
        layoutSortButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.leading.equalTo(buttonView.snp.leading).offset(16)
            make.width.height.equalTo(24)
        }
        layoutToggleButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.trailing.equalTo(buttonView.snp.trailing).offset(-16)
            make.width.height.equalTo(36)
        }
        sortTitle.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.leading.equalTo(layoutSortButton.snp.trailing).offset(8)
            make.trailing.equalTo(layoutToggleButton.snp.leading).offset(10)
            make.height.equalTo(20)
        }
        catalogCollectionView.snp.makeConstraints { make in
            topConstraint = make.top.equalTo(buttonView.snp.bottom).constraint
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
    //MARK: - тело функции
    
    // Перестроение ячейки
    private func updateCollectionViewLayout(animated: Bool = true) {
        let layout = UICollectionViewFlowLayout()
        
        switch viewModel.viewMode {
        case .grid:
            layout.itemSize = CGSize(width: 165, height: 180)
            layout.sectionInsetReference = .fromSafeArea
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            
        case .large:
            layout.itemSize = CGSize(width: 343, height: 278)
            layout.sectionInsetReference = .fromSafeArea
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            
        case .list:
            layout.itemSize = CGSize(width: 343, height: 130)
            layout.sectionInsetReference = .fromSafeArea
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        }
        
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.catalogCollectionView.setCollectionViewLayout(layout, animated: true)
            }
        } else {
            catalogCollectionView.collectionViewLayout = layout
        }
    }
    //Обнавление кнопка изменит
    private func updateButtonIcon() {
        let iconName: String
        
        switch viewModel.viewMode {
        case .grid:
            iconName = "grid_type"
        case .large:
            iconName = "large_type"
        case .list:
            iconName = "list_type"
        }
        layoutToggleButton.setImage(UIImage(named: iconName), for: .normal)
    }
    
    private func updateSortButton() {
        let iconName: String
        let sortTitle: String
        switch viewModel.sortOption {
        case .priceAscending:
            iconName = "sort_price_ascending"
        case .priceDescending:
            iconName = "sort_price_descending"
        case .popularity:
            iconName = "sort_price_ascending"
           }
        
        self.layoutSortButton.setImage(UIImage(named: iconName), for: .normal)
        sortTitle = viewModel.sortOption.rawValue
        self.sortTitle.text = sortTitle
    }
    
    @objc private func toggleView() {
        viewModel.toggleViewMode()
        self.updateButtonIcon()
        
    }
    
    @objc private func sortView() {
        let tableVC = SortTypeTableView(selectedOption: viewModel.sortOption)
        tableVC.onSortedSelected = { [weak self] selectedOption in
            self?.viewModel.sortOption = selectedOption
            self?.updateSortButton()
        }
       
        
        if let sheet = tableVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(tableVC, animated: true)
        
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
        let defaultHeaderTopOffset: CGFloat = 16
        
        //  Анимация исчезновения заголовка
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
        
        //  Двигаем `headerLabel` вверх при скролле
        let headerNewTop = min(minTop, defaultHeaderTopOffset - offset)
        headerLabel.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(headerNewTop)
        }
        
        if let headerFrame = headerLabel.superview?.convert(headerLabel.frame, to: view) {
            let maxTop = headerFrame.maxY + 16
            let newViewTop = max(minTop, maxTop - offset)
            topConstraintView?.update(offset: newViewTop - maxTop + 16)
        }
        
        //  Двигаем `collectionView` вверх
        if let headerFrame = headerLabel.superview?.convert(buttonView.frame, to: view) {
            let maxTop = headerFrame.maxY
            let newCollectionTop = max(minTop, maxTop - offset)
            topConstraint?.update(offset: newCollectionTop - maxTop)
            
        }
        
        // Появление title при поднятие
        let shouldShowTitle = offset > 100
        
        
        UIView.animate(withDuration: 0.2) {
            self.title = shouldShowTitle ? "Каталог" : ""
            self.view.layoutIfNeeded()
        }
        
    }
    
}
