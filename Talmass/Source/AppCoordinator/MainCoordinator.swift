//
//  MainCoordinator.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 27.03.2025.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func greetingDetailData(product: Product)
}

class MainCoordinator {
    var window: UIWindow?
    var navigationController: UINavigationController?
    weak var delegate: MainCoordinatorDelegate?
    
    init(window: UIWindow? = nil) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let navController = UINavigationController(rootViewController: tabBarController)
        self.navigationController = navController
        window?.rootViewController = navController
        
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        let authCoordinates = AuthCoordinator(window: window)
        authCoordinates.start()
    }
    
}
