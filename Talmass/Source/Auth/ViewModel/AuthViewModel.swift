import Foundation

class AuthViewModel {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    var onValidSuccess: (() -> Void)?
    var onValidationError: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    func validateInputs(name: String, email: String, phone: String, password: String){
        if name.isEmpty || phone.isEmpty || password.isEmpty || email.isEmpty {
            onValidationError?("Вся поля должны быть заполнены")
            return
        }
        
        if !isValidEmail(email) {
            onValidationError?("Некорректный email")
            return
        }
        if password.count < 6 {
            onValidationError?("Пароль должен быть не менее 6 символов")
            return
        }
        
        onValidSuccess?()
    }
    
    func validateInputs(email: String, password: String){
        if email.isEmpty || password.isEmpty {
            onValidationError?("Вся поля должны быть заполнены")
            return
        }
        
        if !isValidEmail(email) {
            onValidationError?("Некорректный email")
            return
        }
        
        onValidSuccess?()
    }
    
    func register(name: String, email: String, phone: String, password: String, deviceToken: String) {
        onLoadingStateChange?(true)
        
        let user = RegisterUser(deviceToken: deviceToken, email: email, name: name, password: password, phoneNumber: phone)
        AuthApiManager.shared.registerUser(registrUserRequest: user) { [weak self] result in
            DispatchQueue.main.async {
                self?.onLoadingStateChange?(false)
                switch result {
                case .success(_):
                    self?.onSuccess?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func login(email: String, password: String, deviceToken: String) {
        
        onLoadingStateChange?(true)
        
        let user = User(deviceToken: deviceToken, email: email, password: password)
        
        AuthApiManager.shared.loginUser(loginUserRequest: user) { [ weak self ] result in
            DispatchQueue.main.async {
                self?.onLoadingStateChange?(false)
                
                switch result {
                case .success(let token):
                    print("Token: \(token)")
                    self?.onSuccess?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-z0-9._%+_]+@[a-z0-9._]+\\.[a-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
