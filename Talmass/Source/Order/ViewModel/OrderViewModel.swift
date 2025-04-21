import UIKit

class OrderViewModel {
    var orderUser: UserModel? {
        didSet{
            onUserUpdated?(orderUser)
        }
    }
    var onUserUpdated: ((UserModel?) -> Void)?
    
    public func fetchUser() {
        ApiManager.shared.fetchUser { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.orderUser = user
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
