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
        let basketVM = BasketViewModel()
        let profileVM = ProfileViewModel()
        let orderVM = OrderViewModel()
        
        let tabBarController = TabBarController()
        tabBarController.basketViewModel = basketVM
        tabBarController.profileViewModel = profileVM
        tabBarController.genetateTabBar()
        
        basketVM.onGoToTapped = {
            tabBarController.selectedIndex = 1
        }
        basketVM.onOrderTapped = {
            self.showOrder(viewModel: orderVM)
        }
        profileVM.onLogout = {
            self.logout()
        }
        profileVM.onInfoTapped = { [weak self] userInfo in
            self?.showMyInfo(userInfo: userInfo)
        }
        
        let navController = UINavigationController(rootViewController: tabBarController)
        self.navigationController = navController
        window?.rootViewController = navController
        
    }
    
    func showOrder(viewModel: OrderViewModel) {
        let orderVC = OrderView(viewModel: viewModel)
        navigationController?.pushViewController(orderVC, animated: true)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        let authCoordinates = AuthCoordinator(window: window)
        authCoordinates.start()
    }
    
    func showMyInfo(userInfo: UserInformationModel?) {
        let myInfoVC = MyInfoPageView()
        myInfoVC.configureUI(userInfo: userInfo)
        
        myInfoVC.onSaveButtonTapped = { [weak self] updatedUser in
                if let profileVM = (self?.navigationController?.viewControllers.first as? TabBarController)?.profileViewModel {
                    print("Data sent")
                    profileVM.checkInputinformation(userData: updatedUser) { errorType in

                    }
                    profileVM.updateUserInformation(updateData: updatedUser)
                }
            }
        
        navigationController?.pushViewController(myInfoVC, animated: true)
    }
    
}
