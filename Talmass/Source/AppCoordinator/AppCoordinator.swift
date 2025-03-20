import UIKit

class AppCoordinator {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let hasSeenOnboarding = false
        let isLoggedIn = false
        //        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        //                let isLoggedIn = UserDefaults.standard.string(forKey: "accessToken") != nil
        
        if !hasSeenOnboarding {
            showOnboarding()
        } else if !isLoggedIn {
            showAuthFlow()
        } else {
            showMainFlow()
        }
    }
    
    func showOnboarding() {
        let onBoardingVC = OnboardingView()
        onBoardingVC.viewModel.onFinished = { [ weak self ] in
            //            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            self?.showAuthFlow()
        }
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .fade
        window?.layer.add(transition, forKey: kCATransition)
        
        window?.rootViewController = onBoardingVC
    }
    
    func showAuthFlow() {
        let authCoordinator = AuthCoordinator(window: window)
        authCoordinator.start()
    }
    
    func showMainFlow() {
        //            let mainCoordinator = MainCoordinator(window: window)
        //            mainCoordinator.start()
    }
    
}
