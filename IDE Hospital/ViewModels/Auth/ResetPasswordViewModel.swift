//
//  ResetPasswordViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import Foundation

protocol ResetPasswordViewModelProtocol {
    func resetPassword(email: String?)
}

class ResetPasswordViewModel {
    
    // MARK:- Private Properties
    weak private var view: ResetPasswordVCProtocol?
    
    // MARK:- Init
    init(view: ResetPasswordVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension ResetPasswordViewModel: ResetPasswordViewModelProtocol {
    func resetPassword(email: String?) {
        if validateFields(email: email) {
            let userData = UserData(name: nil, email: email!, mobile: nil, password: nil)
            self.view?.showLoader()
            resetPassword(email: userData)
        }
    }
}

//MARK:- Validations
extension ResetPasswordViewModel {
    private func validateFields(email: String?) -> Bool {
    
        if email.isBlank {
            self.view?.showAlert(message: L10n.emailValidation)
            return false
        }
        
        if !Validator.shared().isValid(loginEmailField: email!) {
            self.view?.showAlert(message: L10n.enterValidEmail)
            return false
        }
        return true
    }
}

//MARK:- APIs
extension ResetPasswordViewModel {
    private func resetPassword(email: UserData){
        APIManager.resetPassword(userData: email) { (response) in
            switch response {
            case .success(let result):
                if result.code == 202 {
                    self.view?.showSuccess(with: L10n.youWillReviceAnEmailWithStepsToHowToResetYourPassword)
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
