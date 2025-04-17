//
//  OnboardingView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 14.03.2025.
//

import UIKit
import SnapKit

class OnboardingView: UIViewController {
    
    public let viewModel = OnboardingViewModel()
    private var pageViewController: UIPageViewController!
    
    private let nextButton: UIButton = {
            let button = UIButton()
            button.setTitle("Далее", for: .normal)
            button.backgroundColor = .brown
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
        
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupUI()
        setupConstraints()
        bindViewModel()
        nextButton.addTarget(self, action: #selector(nextPageTapped), for: .touchUpInside)
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal)
        
        if let firstVC = viewControllerForPage(viewModel.getCurrentPage()) {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
    }
    private func setupUI() {
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    private func viewControllerForPage(_ page: OnboardingModel) -> OnboardingPageView? {
        let vc = OnboardingPageView()
        vc.page = page
        return vc
    }
    
    private func bindViewModel() {
        viewModel.onPageChanged = { [weak self] index in
            guard let self = self else { return }
            if let vc = self.viewControllerForPage(self.viewModel.getCurrentPage()) {
                let direction: UIPageViewController.NavigationDirection = .forward
                self.pageViewController.setViewControllers([vc], direction: direction, animated: true)
            }
        }
    }

    @objc private func nextPageTapped() {
            viewModel.nextPage()
        }
}

