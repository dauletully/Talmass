//
//  CustomPromoButton.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 10.04.2025.
//
import UIKit
import SnapKit

final class PromoCodeButtonView: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "promocodeIcon"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ввести промокод"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = UIColor.brown
        return imageView
    }()

    private let tapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()

    var onTap: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
    
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(arrowImageView)
        addSubview(tapButton)

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }

        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        tapButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        tapButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    @objc private func didTap() {
        onTap?()
        print("PromoCode tapped")
    }
}
