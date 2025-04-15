//
//  Untitled.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.04.2025.
//
import UIKit
import SnapKit

class SuccessOrderView: UIViewController {
    var successView: UIView = {
      let view = UIView()
      view.isHidden = true
      view.backgroundColor = .white
      
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
      imageView.image = UIImage(named: "SuccessOrderIcon")
      imageView.contentMode = .scaleAspectFit
      
      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 327, height: 28))
      titleLabel.text = "Ваш заказ принят"
      
      let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 327, height: 69))
      subtitleLabel.text = "Сейчас на ваш номер должна прийти смс с номера Tallmass. Наши менеджеры свяжутся с Вами в ближайшее время."
      
      let button = UIButton(type: .system)
      button.setTitle("Понятно", for: .normal)
      button.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
      button.setTitleColor(.white, for: .normal)
      button.layer.cornerRadius = 20
      button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      
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
          make.height.equalTo(56)
          make.width.equalTo(327)
      }
      
      view.translatesAutoresizingMaskIntoConstraints = false
      
      return view
  }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupUI()
    }
    
    private func setupUI() {
        view.addSubview(successView)
        
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped() {
        dismiss(animated: true)
    }
}
