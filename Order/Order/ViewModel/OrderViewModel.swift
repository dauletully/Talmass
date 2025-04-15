import UIKit

class OrderViewModel {
    private var order = OrderModel(name: "", phone: "", email: "", isPickup: true)
    
    var onOrderSuccess: ((OrderResponse) -> Void)?
    var onOrderError: ((String) -> Void)?
    
    // MARK: - Public Methods
    func updateName(_ name: String) {
        order.name = name
    }
    
    func updatePhone(_ phone: String) {
        order.phone = phone
    }
    
    func updateEmail(_ email: String) {
        order.email = email
    }
    
    func updateDeliveryType(isPickup: Bool) {
        order.isPickup = isPickup
    }
    
    func submitOrder() {
        // Validate fields
        guard !order.name.isEmpty else {
            onOrderError?("Пожалуйста, введите имя")
            return
        }
        
        guard !order.phone.isEmpty else {
            onOrderError?("Пожалуйста, введите номер телефона")
            return
        }
        
        guard !order.email.isEmpty else {
            onOrderError?("Пожалуйста, введите email")
            return
        }
        
        // Here would be API call to submit order
        // For now simulating API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let response = OrderResponse(
                success: true,
                message: "Заказ успешно оформлен",
                orderId: "ORD-\(Int.random(in: 1000...9999))"
            )
            self?.onOrderSuccess?(response)
        }
    }
} 