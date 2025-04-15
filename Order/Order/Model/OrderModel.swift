struct OrderModel {
    var name: String
    var phone: String
    var email: String
    var isPickup: Bool
}

struct OrderResponse {
    let success: Bool
    let message: String
    let orderId: String?
} 