import UIKit

class MainCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController?

    func start() {
        let viewController = MainViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        let authCoordinates = AuthCoordinator(window: window)
        authCoordinates.start()
    }

    func showOrderScreen() {
        let orderVC = OrderView()
        navigationController?.pushViewController(orderVC, animated: true)
    }
} 