import Foundation

class RegisterViewModel {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    var onValidSuccess: (() -> Void)?
    var onValidationError: ((String) -> Void)?
    
    func validateInputs(name: String, email: String, phone: String, password: String){
        if name.isEmpty || phone.isEmpty || password.isEmpty || email.isEmpty {
            onValidationError?("Вся поля должны быть заполнены")
            return
        }
        
        if isValidEmail(email) {
            onValidationError?("Некорректный email")
            return
        }
        if password.count < 6 {
            onValidationError?("Пароль должен быть не менее 6 символов")
            return
        }
        
        onValidSuccess?()
    }
    
    func register(name: String, email: String, phone: String, password: String, deviceToken: String) {
        let user = RegisterUser(devicaToken: deviceToken, email: email, name: name, password: password, phoneNumber: phone)
        
        ApiManager.shared.registerUser(registrUserRequest: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.onSuccess?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
