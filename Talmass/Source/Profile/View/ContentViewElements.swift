//
//  ContentViewElements.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 16.04.2025.
//

import UIKit
import SnapKit

class ContentViewElements: UIView {
    
    var onLogOutTapped: (() -> Void)?
    var onInfoTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        // Первый блок
        let firstBlock = UIView()
        firstBlock.layer.cornerRadius = 25
        firstBlock.backgroundColor = .white
        firstBlock.layer.borderColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1).cgColor
        firstBlock.layer.borderWidth = 2
        addSubview(firstBlock)
        
        firstBlock.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        let button1 = createButton(icon: "dataIcon", title: "Мои данные")
        let button2 = createButton(icon: "lockIcon", title: "Сменить пароль")
        let button3 = createButton(icon: "notifIcon", title: "Уведомления")
        
        firstBlock.addSubview(button1)
        firstBlock.addSubview(button2)
        firstBlock.addSubview(button3)
        
        button1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(1)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(1)
            $0.left.right.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        // Второй блок
        let secondBlock = UIView()
        secondBlock.layer.cornerRadius = 25
        secondBlock.backgroundColor = .white
        secondBlock.layer.borderColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1).cgColor
        secondBlock.layer.borderWidth = 2
        addSubview(secondBlock)
        
        secondBlock.snp.makeConstraints {
            $0.top.equalTo(firstBlock.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        let button4 = createButton(icon: "writeIcon", title: "Связаться с нами")
        let button5 = createButton(icon: "starIcon", title: "Оставить отзыв")
        let button6 = createButton(icon: "infoIcon", title: "Информация")
        
        secondBlock.addSubview(button4)
        secondBlock.addSubview(button5)
        secondBlock.addSubview(button6)
        
        button4.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        button5.snp.makeConstraints {
            $0.top.equalTo(button4.snp.bottom).offset(1)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        button6.snp.makeConstraints {
            $0.top.equalTo(button5.snp.bottom).offset(1)
            $0.left.right.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        
        // Кнопка "Выйти"
        let logoutButton = createButton(icon: "logoutIcon", title: "Выйти", iconColor: .gray, titleColor: .gray, isLogout: true)
        addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(secondBlock.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(48)
        }
        
        // Добавь действия при нажатии
        button1.addTarget(self, action: #selector(tapMyData), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tapChangePassword), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(tapLogout), for: .touchUpInside)
    }
    
    private func createButton(icon: String, title: String, iconColor: UIColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), titleColor: UIColor = .black, isLogout: Bool = false) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        
        let iconImage = UIImage(named: icon)
        button.setImage(iconImage, for: .normal)
        button.tintColor = iconColor
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        let arrow = UIImageView(image: UIImage(named: "rightIcon"))
        if !isLogout {
            button.addSubview(arrow)
            
            arrow.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.right.equalToSuperview()
                $0.width.height.equalTo(16)
            }
        }
        
        return button
    }
    
    // MARK: - Actions
    @objc private func tapMyData() {
        self.onInfoTapped?()
    }
    
    @objc private func tapChangePassword() {
        print("Сменить пароль нажат")
    }
    
    @objc private func tapLogout() {
        self.onLogOutTapped?()
    }
}
