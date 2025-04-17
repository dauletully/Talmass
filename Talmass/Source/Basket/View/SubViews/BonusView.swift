//
//  BonusView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 09.04.2025.
//
import UIKit
import SnapKit

class BonusView: UIView {
    
    private lazy var onBonusUsing = false
    public var onBonusUsed: ((Int) -> Void)?
    private var bonusAmountValue: Int = 0 {
        didSet {
            bonusAmountLabel.text = "\(bonusAmountValue)"
        }
    }
    
    private lazy var useBonuslabel: UILabel = {
       let label = UILabel()
        label.text = "Списать бонусы"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private lazy var bonusAmountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 33, height: 22))
    private lazy var bonusIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    private lazy var bonusAmount: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = true
        
        bonusAmountLabel.text = "0"
        bonusAmountLabel.textAlignment = .right
        bonusIcon.image = UIImage(named: "bonusIcon")
    
        stackView.addArrangedSubview(bonusAmountLabel)
        stackView.addArrangedSubview(bonusIcon)
        
        return stackView
    }()
    
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Баллами можно оплатить до 30% от стоимости заказа."
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private lazy var useButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "toggleOff"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleUseBonus), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    private lazy var promocodeButton = PromoCodeButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(useBonuslabel)
        addSubview(bonusAmount)
        addSubview(useButton)
        addSubview(warningLabel)
        addSubview(promocodeButton)
        promocodeButton.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        useBonuslabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(31)
        }
        bonusAmount.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(useBonuslabel.snp.trailing).offset(4)
            make.width.equalTo(60)
            make.height.equalTo(31)
        }
        useButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(51)
            make.height.equalTo(31)
        }
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(useBonuslabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalTo(useButton.snp.leading).offset(-12)
        }
        promocodeButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    public func configureBonusView(bonusAmount: Int?) {
        self.bonusAmountValue = bonusAmount ?? 0
    }
    
    @objc private func toggleUseBonus() {
        if onBonusUsing {
            onBonusUsing = false
            self.useButton.setImage(UIImage(named: "toggleOff"), for: .normal)
        } else {
            onBonusUsing = true
            self.useButton.setImage(UIImage(named: "toggleOn"), for: .normal)
            self.onBonusUsed?(self.bonusAmountValue)
        }
    }
    
     
    
}
