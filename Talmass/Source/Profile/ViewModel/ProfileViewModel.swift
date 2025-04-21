//
//  ProfileViewModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 15.04.2025.
//
import UIKit

class ProfileViewModel {
    
    var userInformation: UserInformationModel? {
        didSet {
            onProfileUpdated?(userInformation!)
        }
    }
    
    var onProfileUpdated: ((UserInformationModel) -> Void)?
    
    var onLogout: (() -> Void)?
    
    var onInfoTapped: ((UserInformationModel?) -> Void)?
    
    func logout() {
        onLogout?()
    }
    
    func fetchUserInformation() {
        ApiManager.shared.fetchUserInformation { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.userInformation = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func checkInputinformation(userData: UserInformationModel, completion: @escaping (String) -> Void) {
        if userData.name.isEmpty {
            completion("Name field can not be empty. Write your name")
            return
        } else if userData.email.isEmpty {
            completion("Email field can not be empty. Write your email")
            return
        } else if userData.phoneNumber.isEmpty {
            completion("Phone number field can not be empty. Write your phone number")
            return
        }
        updateUserInformation(updateData: userData)
    }
    
    func updateUserInformation(updateData: UserInformationModel) {
        ApiManager.shared.updateUserInformation(updatedData: updateData) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success:
                    self.fetchUserInformation()
                    print("User information updated")
                }
            }
        }
    }
}
