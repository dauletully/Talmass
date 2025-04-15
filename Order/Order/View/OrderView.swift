import UIKit
import SnapKit

class OrderView: UIViewController {
    private let viewModel = OrderViewModel()
    
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
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер телефона"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.keyboardType = .emailAddress
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
        
        nameTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        deliveryTypeSegmentControl.addTarget(self, action: #selector(deliveryTypeChanged), for: .valueChanged)
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
        viewModel.onOrderSuccess = { [weak self] response in
            let alert = UIAlertController(
                title: "Успешно",
                message: "\(response.message)\nНомер заказа: \(response.orderId ?? "")",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self?.navigationController?.popViewController(animated: true)
            })
            self?.present(alert, animated: true)
        }
        
        viewModel.onOrderError = { [weak self] error in
            let alert = UIAlertController(
                title: "Ошибка",
                message: error,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    // MARK: - Actions
    @objc private func submitButtonTapped() {
        viewModel.submitOrder()
    }
    
    @objc private func deliveryTypeChanged(_ sender: UISegmentedControl) {
        viewModel.updateDeliveryType(isPickup: sender.selectedSegmentIndex == 0)
    }
}

// MARK: - UITextFieldDelegate
extension OrderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        switch textField {
        case nameTextField:
            viewModel.updateName(text)
        case phoneTextField:
            viewModel.updatePhone(text)
        case emailTextField:
            viewModel.updateEmail(text)
        default:
            break
        }
        
        return true
    }
} 