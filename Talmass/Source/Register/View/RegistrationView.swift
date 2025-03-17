//
//  RegistrationView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.03.2025.
//

import UIKit
import SnapKit

class RegistrationView: UIViewController {
    
    private let viewModel = RegisterViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы с вами научимся заниматься на тренажере-массажере для спины Talmass"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Ваше имя"
        label.font = .systemFont(ofSize: 17)
        label.borderStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        label.autocorrectionType = .no
        label.autocapitalizationType = .none
        label.delegate = self
        label.tag = 1
       
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Email"
        label.font = .systemFont(ofSize: 17)
        label.borderStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyboardType = .emailAddress
        label.autocorrectionType = .no
        label.autocapitalizationType = .none
        label.delegate = self
        label.tag = 2
        
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Номер телефона"
        label.font = .systemFont(ofSize: 17)
        label.borderStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        label.keyboardType = .numberPad
        label.delegate = self
        label.tag = 3
        
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Придумайте пароль"
        label.font = .systemFont(ofSize: 17)
        label.borderStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSecureTextEntry = true
        label.returnKeyType = .done
        label.delegate = self
        label.tag = 4
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        label.rightView = button
        label.rightViewMode = .always
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, phoneNumberTextField, passwordTextField])
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 211/255, green: 200/255, blue: 179/255, alpha: 1)
        button.addTarget(RegistrationView.self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Уже есть аккаунт?"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        button.sizeToFit()
        
        return button
    }()

    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueButton.layer.cornerRadius = 25
    }
    
    func setupBinding() {
        viewModel.onValidationError = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        viewModel.onValidSuccess = {
            self.registerUser()
        }
        viewModel.onSuccess = {
            print("✅ Регистрация успешна!")
        }
        viewModel.onError =  { error in
            print("❌ Ошибка регистрации: \(error)")
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()

        setupUI()
        setupConstraints()
        setupBinding()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        view.addSubview(continueButton)
        view.addSubview(loginStackView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(34)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(101)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(228)
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginStackView.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(56)
        }
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(190)
            make.height.equalTo(20)
            
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func registerUser() {
        let name = self.nameTextField.text ?? ""
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let phoneNumber = self.phoneNumberTextField.text ?? ""
        let deviceToken = "123456789abcd"
        
        self.viewModel.register(name: name, email: email, phone: phoneNumber, password: password, deviceToken: deviceToken)
    }
    
    @objc func showPassword() {
        if self.passwordTextField.isSecureTextEntry {
            self.passwordTextField.isSecureTextEntry = false
        } else {
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func addTapped() {
        let name = self.nameTextField.text ?? ""
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let phoneNumber = self.phoneNumberTextField.text ?? ""
        
        viewModel.validateInputs(name: name, email: email, phone: phoneNumber, password: password)
    }
    
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
