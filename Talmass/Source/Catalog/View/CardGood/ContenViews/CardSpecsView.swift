//
//  CardSpecsView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 28.03.2025.
//
import UIKit
import SnapKit

class CardSpecsView: UIView {
    
    private let iconHeight: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "height_icon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabelHeight: UILabel = {
        let label = UILabel()
        label.text = "Рост"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var valueLabelHeight: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    //Разделительная линия
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }()
    
    private let iconSize: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "size_icon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabelSize: UILabel = {
        let label = UILabel()
        label.text = "Размер"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var valueLabelSize: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.clipsToBounds = true
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
        addSubview(iconHeight)
        addSubview(titleLabelHeight)
        addSubview(valueLabelHeight)
        addSubview(separator)
        addSubview(iconSize)
        addSubview(titleLabelSize)
        addSubview(valueLabelSize)
    }
    
    private func setupConstraints() {
        iconHeight.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabelHeight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalTo(iconHeight.snp.trailing).offset(16)
            make.trailing.equalTo(valueLabelHeight.snp.leading)
            make.height.equalTo(20)
        }
        
        valueLabelHeight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(iconHeight.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        iconSize.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabelSize.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(22)
            make.leading.equalTo(iconSize.snp.trailing).offset(16)
            make.trailing.equalTo(valueLabelSize.snp.leading)
            make.height.equalTo(20)
        }
        
        valueLabelSize.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(22)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(110)
            make.height.equalTo(20)
        }
    }
    
    public func configure(size: String, height: String) {
        self.valueLabelHeight.text = "от \(height)"
        self.valueLabelSize.text = size
    }
    
}


