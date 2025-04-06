//
//  AuthCoordinator.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.03.2025.
//
import UIKit

class AuthCoordinator: AuthFlowDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    init (window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let loginVC = LoginView()
        loginVC.delegate = self
        
        loginVC.onLoginSuccess = {
            self.showMainFlow()
        }
        
        loginVC.onRegisterTap = {
            self.showRegister()
        }
        
        let navController = UINavigationController(rootViewController: loginVC)
        self.navigationController = navController
        window?.rootViewController = navController
        
    }
    
    func showRegister() {
        let registerVC = RegistrationView()
        registerVC.delegate = self // 👈 Устанавливаем делегат
        registerVC.viewModel.onSuccess = {
            self.showMainFlow()
        }
        navigationController?.pushViewController(registerVC, animated: true)
        
        
    }
    
    func showMainFlow() {
        print("Переход на главный экран")
        let mainCoordinator = MainCoordinator(window: window)
        mainCoordinator.start()
    }
    
    func didRequestLogin() {
        print("✅ Переход на экран логина")
        navigationController?.popViewController(animated: true)
    }
}
