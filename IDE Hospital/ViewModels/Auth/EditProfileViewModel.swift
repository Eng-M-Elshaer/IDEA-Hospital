//
//  EditProfileViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import Foundation

protocol EditProfileViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, confrimPassword: String?, oldPassword: String?)
    func getUserData()
}

class EditProfileViewModel {
    
    // MARK:- Private Properties
    private weak var view: EditProfileVCProtocol?

    // MARK:- Init
    init(view: EditProfileVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension EditProfileViewModel: EditProfileViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, confrimPassword: String?, oldPassword: String?) {
        if  vaildFields(name: name, email: email, mobile: mobile, password: password, confirmPassowrd: confrimPassword, oldPassword: oldPassword) {
            var user: UserData!
            if oldPassword == "" {
                user = UserData(name: name!, email: email!, mobile: mobile!)
            } else{
                user = UserData(name: name!, email: email!, mobile: mobile!, password: password!, oldPassword: oldPassword!)
            }
            editUser(userData: user)
        }
    }
    func getUserData(){
        self.view?.showLoader()
        APIManager.getUserData { (response) in
            switch response {
            case .success(let result):
                if result.code == 200 {
                    guard let data = result.data else {return}
                    self.view?.setUserData(user: data)
                } else {
                    if let errorMessages = result.errors?.formattedErrors() {
                        self.view?.showAlert(message: errorMessages)
                    } else {
                        self.view?.showAlert(message: result.message ?? "N/A")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
}

//MARK:- Validations
extension EditProfileViewModel {
    private func vaildPassword(password: String, confirmPassword: String) -> Bool {
       return password == confirmPassword
    }
    private func vaildFields(name: String?, email: String?, mobile: String?, password: String?, confirmPassowrd: String?, oldPassword: String?) -> Bool {
        if name.isBlank {
            self.view?.showAlert(message: L10n.nameValidation)
            return false
        }
        if email.isBlank {
            self.view?.showAlert(message: L10n.emailValidation)
            return false
        }
        if !Validator.shared().isValid(loginEmailField: email!) {
            self.view?.showAlert(message: L10n.emailValidation)
            return false
        }
        if mobile.isBlank {
            self.view?.showAlert(message: L10n.mobileValidation)
            return false
        }
        if !Validator.shared().isValid(entry: mobile!, type: .mobile) {
            self.view?.showAlert(message: L10n.enterValidMobile)
            return false
        }
        if !oldPassword.isBlank {
            if !Validator.shared().isValid(entry: oldPassword!, type: .password) {
                self.view?.showAlert(message: L10n.enterVaildPassword)
                return false
            }
            if password.isBlank {
                self.view?.showAlert(message: L10n.passwordNewValidation)
                return false
            }
            if !Validator.shared().isValid(entry: password!, type: .password) {
                self.view?.showAlert(message: L10n.enterVaildPassword)
                return false
            }
            if confirmPassowrd.isBlank {
                self.view?.showAlert(message: L10n.passwordConfirmValidation)
                return false
            }
            if !vaildPassword(password: password!, confirmPassword: confirmPassowrd!) {
                self.view?.showAlert(message: L10n.passwordValidationNotMatch)
                return false
            }
            return true
        }
        return true
    }
}

//MARK:- APIs
extension EditProfileViewModel {
    private func editUser(userData: UserData?){
        self.view?.showLoader()
        APIManager.editProfile(userData: userData!) { (response) in
            switch response {
            case .success(let result):
                if result.code == 200 {
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view?.showSuccess(with: L10n.yourDataHasBeUpdated)
                } else {
                    if let errorMessages = result.errors?.formattedErrors() {
                        self.view?.showAlert(message: errorMessages)
                    } else {
                        self.view?.showAlert(message: result.message ?? "N/A")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
}
