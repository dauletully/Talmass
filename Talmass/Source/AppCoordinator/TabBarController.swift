//
//  TabBarController.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 27.03.2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    var basketViewModel: BasketViewModel?
    var profileViewModel: ProfileViewModel?
    var courseViewModel: CourseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        genetateTabBar()
//        configureTabBar()
    }
    
    public func genetateTabBar() {
        let basketVC = BasketView(viewModel: basketViewModel ?? BasketViewModel())
        let profileVC = ProfileView(viewModel: profileViewModel ?? ProfileViewModel())
        let courseVC = CourseView(viewModel: courseViewModel ?? CourseViewModel())
        
        viewControllers = [
            generateViewController(
                viewController: courseVC,
                image: UIImage(named: "course_icon")!,
                title: "Курсы"),
            generateViewController(
                viewController: CatalogView(),
                image: UIImage(named: "market_icon")!,
                title: "Каталог"),
            generateViewController(
                viewController: basketVC,
                image: UIImage(named: "busket_icon")!,
                title: "Корзина"),
            generateViewController(
                viewController: profileVC,
                image: UIImage(named: "profile_icon")!,
                title: "Профиль")
        ]
        
        self.configureTabBar()
    }
    
    private func generateViewController(viewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        
        return viewController
    }
    
    private func configureTabBar() {
        tabBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.94)
        selectedIndex = 1
        
        let appearance = UITabBarAppearance()
        let appereanceItem = UITabBarItemAppearance()
        
        appereanceItem.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        appereanceItem.selected.iconColor = .black
        appereanceItem.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        
        appearance.stackedLayoutAppearance = appereanceItem
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
}
