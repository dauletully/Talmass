//
//  BasketView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 08.04.2025.
//

import UIKit
import SnapKit

class BasketView: UIViewController {
    
    private let identifier: String = "BasketProductCollectionViewCell"
    
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
        layout.itemSize = CGSize(width: 343, height: 130)
        layout.scrollDirection = .vertical
        layout.sectionInsetReference = .fromSafeArea
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.contentView.layer.cornerRadius = 24
        self.contentView.clipsToBounds = true
        self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1)
        view.addSubview(headerLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(basketProductCollectionView)
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
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(basketProductCollectionView.snp.bottom).offset(20)
        }
        basketProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(250)
        }
    }
}

extension BasketView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BasketCollectionViewCell else {return BasketCollectionViewCell()}
            
        
        return cell
    }
    
    
}
