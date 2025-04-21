//
//  CourseCollectionViewCell.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//
import UIKit
import SnapKit

class CourseCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
    
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private lazy var countLesson: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 13)
        title.textColor = .gray
        
        return title
    }()
    
    private lazy var nameCourse: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.textColor = .black
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        return title
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        
        self.imageView.layer.cornerRadius = 16
        self.imageView.clipsToBounds = true
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
        addSubview(imageView)
        addSubview(activityIndicator)
        addSubview(countLesson)
        addSubview(nameCourse)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(8)
            make.width.equalTo(96)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
        countLesson.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(16)
        }
        nameCourse.snp.makeConstraints { make in
            make.top.equalTo(countLesson.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    public func configureUI(for course: CourseModel, viewModel: CourseViewModel) {
        activityIndicator.startAnimating()
        
        viewModel.loadImage(for: course.imageSrc) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
        self.countLesson.text = "\(course.lessonCnt) уроков"
        self.nameCourse.text = course.name
    }
}
