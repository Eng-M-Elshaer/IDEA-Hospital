//
//  SignInViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import Foundation

protocol SignInViewModelProtocol {
    func authWithEmail(email: String?, password: String?)
}

class SignInViewModel {
    
    // MARK:- Private Properties
    weak private var view: SignInVCProtocol?
    
    // MARK:- Init
    init(view: SignInVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension SignInViewModel: SignInViewModelProtocol {
    func loginWith(email: String?, password: String?) {
        let userData = UserData(name: nil, email: email!, mobile: nil, password: password!)
        APIManager.login(userData: userData) { (response) in
            switch response {
            case .success(let result):
                if result.code == 201 {
                    guard let data = result.data else {return}
                    UserDefaultsManager.shared().token = data.accessToken
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view?.showSuccess(with: L10n.youHaveBeLoginSuccessfully)
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
    func authWithEmail(email: String?, password: String?) {
        if self.validateFields(email: email, password: password) {
            self.view?.showLoader()
            loginWith(email: email, password: password)
        }
    }
}

//MARK:- Validations
extension SignInViewModel {
    private func validateFields(email: String?, password: String?) -> Bool {
        if email.isBlank || password.isBlank {
            if email.isBlank {
                self.view?.showAlert(message: L10n.nameValidation)
                return false
            }
            if password.isBlank {
                self.view?.showAlert(message: L10n.passwordValidation)
                return false
            }
            return false
        }
        if !Validator.shared().isValid(loginEmailField: email!) {
            self.view?.showAlert(message: L10n.enterValidEmail)
            return false
        }
        if !Validator.shared().isValid(entry: password!, type: .password) {
            self.view?.showAlert(message: L10n.enterVaildPassword)
            return false
        }
        return true
    }
}
