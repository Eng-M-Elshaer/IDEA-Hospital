//
//  SignUpViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import UIKit

protocol SignUpViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, confrimPassword: String?)
}

class SignUpViewModel {
    
    // MARK:- Private Properties
    private weak var view: SignUpVCProtocol?

    // MARK:- Init
    init(view: SignUpVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension SignUpViewModel: SignUpViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, confrimPassword: String?) {
        if  vaildFields(name: name, email: email, mobile: mobile, password: password, confirmPassowrd: confrimPassword) {
            let userData = UserData(name: name!, email: email!, mobile: mobile!, password: password!)
            setUser(userData: userData)
        }
    }
}

//MARK:- Validations
extension SignUpViewModel {
    private func vaildPassword(password: String, confirmPassword: String) -> Bool {
       return password == confirmPassword
    }
    private func vaildFields(name: String?, email: String?, mobile: String?, password: String?, confirmPassowrd: String?) -> Bool {
        if name.isBlank {
            self.view?.showAlert(message: L10n.nameValidation)
            return false
        }
        if email.isBlank {
            self.view?.showAlert(message: L10n.emailValidation)
            return false
        }
        if !Validator.shared().isValid(loginEmailField: email!) {
            self.view?.showAlert(message: L10n.enterValidEmail)
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
        if password.isBlank {
            self.view?.showAlert(message: L10n.passwordValidation)
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
}

//MARK:- APIs
extension SignUpViewModel {
    private func setUser(userData: UserData){
        self.view?.showLoader()
        APIManager.setUser(userData: userData) { (response) in
            switch response {
            case .success(let result):
                if result.code == 201 {
                    guard let data = result.data else {return}
                    UserDefaultsManager.shared().token = data.accessToken
                    UserDefaultsManager.shared().isLoggedIn = true
                    self.view?.showSuccess(with: L10n.youHaveBeSignUpSuccessfully)
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
