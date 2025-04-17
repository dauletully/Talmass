//
//  MyInfoPageView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 16.04.2025.
//

import UIKit
import SnapKit

class MyInfoPageView: UIViewController {
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.addUnderline()
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stackView.axis = .vertical
        stackView.spacing = 4
    
        return stackView
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.addUnderline()
        textField.delegate = self
        textField.keyboardType = .numbersAndPunctuation
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneNumberLabel, phoneNumberTextField])
        stackView.axis = .vertical
        stackView.spacing = 4
    
        return stackView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.addUnderline()
        textField.delegate = self
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stackView.axis = .vertical
        stackView.spacing = 4
    
        return stackView
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView, phoneNumberStackView, emailStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
    
        return stackView
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    private let genderSegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Не указано", "Мужской", "Женский"])
                                                  
        return segmentedControl
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genderLabel, genderSegment])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var heightTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.placeholder = "Рост"
        textField.addUnderline()
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var weightTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.placeholder = "Вес"
        textField.addUnderline()
        textField.delegate = self
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heightTextField, weightTextField])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша активность"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .gray
        
        return label
    }()
    
    private let activitySegment: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Низкая", "Средняя", "Высокая"])
                                                  
        return segmentedControl
    }()
    
    private lazy var activityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [activityLabel, activitySegment])
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить аккаунт", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить изменения", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        
        return button
    }()
    
    //Ending writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.saveButton.layer.cornerRadius = 20
        self.saveButton.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
        
    }
    
    private func setupUI() {
        view.addSubview(dataStackView)
        view.addSubview(genderStackView)
        view.addSubview(stackView)
        view.addSubview(activityStackView)
        view.addSubview(deleteButton)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        dataStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
        genderStackView.snp.makeConstraints { make in
            make.top.equalTo(dataStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(62)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(56)
        }
        activityStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(62)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(activityStackView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(121)
            make.height.equalTo(44)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }
    
}
extension MyInfoPageView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension UITextField {
    func addUnderline(color: UIColor = .lightGray, height: CGFloat = 1.0) {
        // Удалим старую линию, если вдруг она уже была
        self.subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        let underline = UIView()
        underline.backgroundColor = color
        underline.tag = 999
        self.addSubview(underline)

        underline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underline.heightAnchor.constraint(equalToConstant: height),
            underline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

