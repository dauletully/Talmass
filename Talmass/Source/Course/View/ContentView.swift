//
//  ContentView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//
import UIKit
import SnapKit

class ContentView: UIView {
    
    static let identifier: String = "ContentView"
    
    private var courses: Course = []
    
    public var onCourseUpdated: ((Course) -> Void)?
    
    private lazy var notesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmarkIcon"), for: .normal)
        button.setTitle("Мои закладки", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "viewImage")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var courseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 343, height: 124)
        layout.sectionInsetReference = .fromSafeArea
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: ContentView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.notesButton.layer.borderColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1).cgColor
        self.notesButton.layer.borderWidth = 2
        self.notesButton.layer.cornerRadius = 20
        self.notesButton.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutIfNeeded()
        setupUI()
        setupConstraints()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBinding() {
        self.onCourseUpdated = { [weak self] courseCatalog in
            self?.courses = courseCatalog
            self?.courseCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(notesButton)
        addSubview(imageView)
        addSubview(courseCollectionView)
    }
    
    private func setupConstraints() {
        notesButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(64)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(notesButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(128)
        }
        courseCollectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension ContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentView.identifier, for: indexPath) as? CourseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureUI(for: courses[indexPath.row], viewModel: CourseViewModel())
        
        return cell
    }
    
    
}

