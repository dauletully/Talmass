//
//  OnboardingView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 14.03.2025.
//

import UIKit
import SnapKit

class OnboardingPageView: UIViewController {
    
    var page: OnboardingModel? {
        didSet {
            updateUI()
        }
    }

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 22, weight: .bold)
        title.textColor = .black
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.translatesAutoresizingMaskIntoConstraints = false
        title.sizeToFit()
        
        return title
    }()
    
    private let titleDescriptionLabel: UILabel = {
        let titleDescription = UILabel()
        titleDescription.font = .systemFont(ofSize: 17, weight: .regular)
        titleDescription.textColor = .black
        titleDescription.numberOfLines = 0
        titleDescription.lineBreakMode = .byWordWrapping
        titleDescription.translatesAutoresizingMaskIntoConstraints = false
        titleDescription.sizeToFit()
        
        return titleDescription
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateUI()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(titleDescriptionLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-90)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(66)
        }
        titleDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(66)
        }
    }
    
    private func updateUI() {
        guard let page = page else { return }
        titleLabel.text = page.title
        titleDescriptionLabel.text = page.description
        imageView.image = UIImage(named: page.imageTitle)
    }
}
