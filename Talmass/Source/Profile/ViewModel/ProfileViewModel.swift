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
    
    var onInfoTapped: (() -> Void)?
    
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
    
    func updateUserInformation(updateData: UserInformationModel) {
        ApiManager.shared.updateUserInformation(updatedData: updateData) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success:
                    self.fetchUserInformation()
                }
            }
        }
    }
}
