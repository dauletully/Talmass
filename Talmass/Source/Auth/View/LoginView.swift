//
//  LoginView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 18.03.2025.
//

import UIKit
import SnapKit

protocol AuthFlowDelegate: AnyObject {
    func didRequestRegistration()
    func didRequestLogin()
}

class LoginView: UIViewController {
    
    weak var delegate: AuthFlowDelegate?
    public let viewModel = AuthViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "С возвращением"
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
    
    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Забыли пароль?", for: .normal)
        button.tintColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, forgotButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let loginButton: LoadingButton = {
        let button = LoadingButton()
        button.backgroundColor = UIColor(red: 211/255, green: 200/255, blue: 179/255, alpha: 1)
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще нет аккаунта?"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.sizeToFit()
        
        return button
    }()
    
    private lazy var registerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registrationLabel, registerButton])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private func setupBinding() {
        viewModel.onValidationError = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        viewModel.onValidSuccess = {
            self.loginUser()
        }
        viewModel.onSuccess = {
            print("✅ Вход успешен!")
            
        }
        viewModel.onError =  { error in
            print("❌ Ошибка при входе: \(error)")
        }
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.loginButton.showLoading(isLoading)
            }
        }
//        viewModel.onRegister = { [weak self] in
//            DispatchQueue.main.async {
//                print("✅ Переход на экран регистрации")
//                (UIApplication.shared.delegate as? SceneDelegate)?.appCoordinator?.showAuthFlow()
//            }
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 25
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
        setupBinding()
    }
    
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        view.addSubview(loginButton)
        view.addSubview(registerStackView)
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
            make.height.equalTo(140)
        }
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerStackView.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(56)
        }
        registerStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(20)
        }
        
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func loginUser() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let deviceToken = "123456789abcd"
        
        self.viewModel.login(email: email, password: password, deviceToken: deviceToken)
    }
    @objc func showPassword() {
        if self.passwordTextField.isSecureTextEntry {
            self.passwordTextField.isSecureTextEntry = false
        } else {
            self.passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func addTapped() {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        self.viewModel.validateInputs(email: email, password: password)
    }
    
    @objc func registerButtonTapped() {
        delegate?.didRequestRegistration()
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
