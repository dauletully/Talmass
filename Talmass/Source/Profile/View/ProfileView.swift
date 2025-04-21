//
//  ProfileView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.04.2025.
//

import UIKit

class ProfileView: UIViewController {
    
    private var viewModel: ProfileViewModel
    private var currentUser: UserInformationModel?
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 343, height: 33))
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var phoneNumberTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 327, height: 20))
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTitle, phoneNumberTitle])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    private var bonusCount = UILabel(frame: CGRect(x: 0, y: 0, width: 254, height: 34))
    
    private lazy var bonusView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 204/255, green: 185/255, blue: 149/255, alpha: 1)
        
        let title = UILabel()
        title.text = "Мои баллы >"
        title.textColor = .white
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bonusProfileIcon")
        imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        
        let customImageView = UIImageView()
        customImageView.image = UIImage(named: "pattern")
        
        self.bonusCount.text = "500"
        self.bonusCount.font = .systemFont(ofSize: 28, weight: .bold)
        self.bonusCount.textColor = .white
        
        
        let stackView = UIStackView(arrangedSubviews: [imageView, self.bonusCount])
        stackView.frame = CGRect(x: 0, y: 0, width: 295, height: 34)
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        
        let mainStackView = UIStackView(arrangedSubviews: [title, stackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        
        view.addSubview(mainStackView)
        view.addSubview(customImageView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        customImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(mainStackView.snp.trailing).offset(10)
        }
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 6
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let contentViewElements = ContentViewElements()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bonusView.layer.cornerRadius = 25
        bonusView.clipsToBounds = true
        
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupBinding() {
        self.viewModel.onProfileUpdated = { [weak self] user in
            self?.currentUser = user
            self?.nameTitle.text = user.name
            self?.phoneNumberTitle.text = self?.formatPhoneNumber(user.phoneNumber)
        }
        self.contentViewElements.onLogOutTapped = { [weak self] in
            self?.viewModel.logout()
        }
        self.contentViewElements.onInfoTapped = { [weak self] in
            guard let self = self else {fatalError("Assertion failed")}
            self.viewModel.onInfoTapped?(self.currentUser)
        }
        self.contentViewElements.onConntectedTapped = {
            self.setupConnectType()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        
        setupUI()
        setupConstraints()
        setupBinding()
        
        DispatchQueue.main.async {
            self.viewModel.fetchUserInformation()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 181/255, green: 163/255, blue: 128/255, alpha: 1)
        view.addSubview(nameTitle)
        view.addSubview(phoneNumberTitle)
        view.addSubview(bonusView)
        view.addSubview(contentView)
        contentView.addSubview(contentViewElements)
    }
    
    private func setupConstraints() {
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(33)
        }
        phoneNumberTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(2)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        bonusView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTitle.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(114)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }
        contentViewElements.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    private func setupConnectType() {
        let connectionTypeVC = ConnectionTypeView()
        
        if let sheet = connectionTypeVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(connectionTypeVC, animated: true)
    }
    
    private func formatPhoneNumber(_ raw: String) -> String {
        let digits = raw.filter { $0.isNumber }

        guard digits.count == 11 else { return raw }

        let countryCode = "+7"
        let operatorCode = String(digits.dropFirst().prefix(3))
        let first = String(digits.dropFirst(4).prefix(3))
        let second = String(digits.dropFirst(7).prefix(2))
        let third = String(digits.dropFirst(9).prefix(2))

        return "\(countryCode) \(operatorCode) \(first) \(second) \(third)"
    }
    
}
