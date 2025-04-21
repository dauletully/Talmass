//
//  OrderView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.04.2025.
//

import UIKit
import SnapKit

class OrderView: UIViewController {
    private let viewModel: OrderViewModel
    
    init(viewModel: OrderViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.keyboardType = .phonePad
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.keyboardType = .emailAddress
        textField.delegate = self
        
        return textField
    }()
    
    private let deliveryTypeSegmentControl: UISegmentedControl = {
        let items = ["Самовывоз", "Доставка"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        
        return segmentControl
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оформить заказ", for: .normal)
        button.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 24
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupBindings()
        
        DispatchQueue.main.async {
            self.viewModel.fetchUser()
        }
    }
    //Ending writing 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(deliveryTypeSegmentControl)
        view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
//        deliveryTypeSegmentControl.addTarget(self, action: #selector(deliveryTypeChanged), for: .valueChanged)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(32)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(50)
        }
        
        deliveryTypeSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView).offset(-32)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(56)
        }
    }
    
    private func setupBindings() {
        self.viewModel.onUserUpdated = { [weak self] user in
            self?.nameTextField.text = user?.name
            self?.emailTextField.text = user?.email
            self?.phoneTextField.text = user?.phoneNumber
        }
    }
    
    private func setupSuccessAlert() {
        let successVC = SuccessOrderView()
        
        if let sheet = successVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(successVC, animated: true)
    }
    
    // MARK: - Actions
    @objc private func submitButtonTapped() {
        setupSuccessAlert()
        
        self.emailTextField.text = ""
        self.nameTextField.text = ""
        self.phoneTextField.text = ""
        
    }

}

extension OrderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
