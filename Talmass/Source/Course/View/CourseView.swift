//
//  CourseView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//

import UIKit

class CourseView: UIViewController {
    private var viewModel: CourseViewModel
    
    init(viewModel: CourseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let headerTitle: UILabel = {
        let title = UILabel()
        title.text = "Курсы"
        title.textColor = .black
        title.font = .systemFont(ofSize: 28, weight: .bold)
        
        return title
    }()
    
    private let contentView = ContentView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 24
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupBinding()
        
        DispatchQueue.main.async {
            self.viewModel.fetchCourses()
        }
    }
    
    private func setupBinding() {
        self.viewModel.onCourseUpdated = { [weak self] updatedCourse in
            self?.contentView.onCourseUpdated?(updatedCourse)
        }
       
        
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 243/255, green: 241/255, blue: 240/255, alpha: 1)
        view.addSubview(headerTitle)
        view.addSubview(contentView)
    }
    
    private func setupConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(33)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(23)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
   
}
