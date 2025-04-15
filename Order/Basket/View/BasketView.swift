@objc private func goToPaymentTapped() {
    if let mainCoordinator = UIApplication.shared.windows.first?.rootViewController?.children.first as? UINavigationController {
        let orderVC = OrderView()
        mainCoordinator.pushViewController(orderVC, animated: true)
    }
} 