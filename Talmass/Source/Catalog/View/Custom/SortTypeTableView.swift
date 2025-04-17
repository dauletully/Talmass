//
//  SortTypeTableView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 26.03.2025.
//

import UIKit
import SnapKit

enum SortingOption: String, CaseIterable {
    case popularity = "По популярности"
    case priceAscending = "По возрастанию цены"
    case priceDescending = "По убыванию цены"
}

class SortTypeTableView: UIViewController {
    
    private var selectedOption: SortingOption?
    public var onSortedSelected: ((SortingOption) -> Void)?
    
    init(selectedOption: SortingOption) {
        self.selectedOption = selectedOption
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Сортировка"
        title.font = .systemFont(ofSize: 22, weight: .bold)
        title.textColor = .black
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.rowHeight = 50
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(327)
            make.height.equalTo(24)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SortTypeTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortingOption.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let option = SortingOption.allCases[indexPath.row]
        
        var context = cell.defaultContentConfiguration()
        context.text = option.rawValue
        
        if (selectedOption == nil) {
            selectedOption = .popularity
        }
        
        cell.contentConfiguration = context
        cell.accessoryType = (option == selectedOption) ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.separatorStyle = .none
        selectedOption = SortingOption.allCases[indexPath.row]
        guard let selectedOption = selectedOption else { return }
        onSortedSelected?(selectedOption)
        dismiss(animated: true)
    }
    
    
}
