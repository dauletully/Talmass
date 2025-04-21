//
//  ConnectionTypeView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//

import UIKit
import SnapKit

class ConnectionTypeView: UIViewController {

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Связатся с нами"
        title.textColor = .black
        title.font = .systemFont(ofSize: 20, weight: .bold)
        
        return title
    }()
    
    private var stackView: UIStackView = {
        func createButton(title: String, image: UIImage?) -> UIButton {
            var button = UIButton(type: .system)
            button.contentHorizontalAlignment = .left
            button.setImage(image, for: .normal)
            button.tintColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
            button.setTitle("      \(title)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor(red: 239/255, green: 235/255, blue: 233/255, alpha: 1).cgColor
            
            button.imageView?.snp.makeConstraints{ make in
                make.leading.equalToSuperview().offset(16)
                make.centerY.equalToSuperview()
            }
           
            
            return button
        }
        
        let buttonCall = createButton(title: "Связатся с нами", image: UIImage(named: "phoneIcon"))
        let buttonMessage = createButton(title: "Служба поддержки", image: UIImage(named: "messageIcon"))
        let buttonWhatsapp = createButton(title: "Whatsapp", image: UIImage(named: "whatsappIcon"))
        
        
        let stackView = UIStackView(arrangedSubviews: [buttonCall, buttonMessage, buttonWhatsapp])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
private func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(titleLabel)
    view.addSubview(stackView)
    
}

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(208)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
