//
//  RegisterPopUpViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/20/20.
//

import Foundation

enum PopUpState {
    case register
    case login
}

protocol RegisterPopUpViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, timeStamp: String, doctorID: Int, code: String?, otherName: String?, state: PopUpState, isHaveVoucher: Bool?, isBookForOther: Bool?)
}

class RegisterPopUpViewModel {
    
    // MARK:- Private Properties
    private weak var view: RegisterPopUpVCProtocol?

    // MARK:- Init
    init(view: RegisterPopUpVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension RegisterPopUpViewModel: RegisterPopUpViewModelProtocol {
    func getUserData(name: String?, email: String?, mobile: String?, password: String?, timeStamp: String, doctorID: Int, code: String?, otherName: String?, state: PopUpState, isHaveVoucher: Bool?, isBookForOther: Bool?) {
        
        if vaildFields(name: name, email: email, mobile: mobile, password: password, state: state, voucherCode: code, otherPersonName: otherName, isHaveVoucher: isHaveVoucher, isBookForOther: isBookForOther) {
            var userData: UserData!
            if code == "" {
                if isBookForOther! {
                    userData = UserData(name: name, email: email!, mobile: mobile, password: password, oldPassword: nil, doctorID: doctorID, appointment: timeStamp, patientName: otherName, voucher: nil, isbookForAnother: 1)
                } else {
                    userData = UserData(name: name, email: email!, mobile: mobile, password: password, oldPassword: nil, doctorID: doctorID, appointment: timeStamp, patientName: nil, voucher: nil, isbookForAnother: 0)
                }
            } else {
                if isBookForOther! {
                    userData = UserData(name: name, email: email!, mobile: mobile, password: password, oldPassword: nil, doctorID: doctorID, appointment: timeStamp, patientName: otherName, voucher: code, isbookForAnother: 1)
                } else {
                    userData = UserData(name: name, email: email!, mobile: mobile, password: password, oldPassword: nil, doctorID: doctorID, appointment: timeStamp, patientName: nil, voucher: code, isbookForAnother: 0)
                }
            }
            if state == .register {
                bookWithRegister(userData: userData)
            } else {
                bookWithLogin(userData: userData)
            }
        }
    }
}

//MARK:- Validations
extension RegisterPopUpViewModel {
    private func vaildFields(name: String?, email: String?, mobile: String?, password: String?, state: PopUpState, voucherCode: String?, otherPersonName: String?, isHaveVoucher: Bool?, isBookForOther: Bool?) -> Bool {
        if name.isBlank && state == .register {
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
        if mobile.isBlank && state == .register {
            self.view?.showAlert(message: L10n.mobileValidation)
            return false
        }
        if !Validator.shared().isValid(entry: mobile!, type: .mobile) && state == .register {
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
        if voucherCode.isBlank && isHaveVoucher! {
            self.view?.showAlert(message: L10n.youHaveToEnterVoucher)
            return false
        }
        if otherPersonName.isBlank && isBookForOther! {
            self.view?.showAlert(message: L10n.nameValidation)
            return false
        }
        return true
    }
}

//MARK:- APIs
extension RegisterPopUpViewModel {
    private func bookWithLogin(userData: UserData) {
        self.view?.showLoader()
        APIManager.bookWithLogin(userData: userData) { (response) in
            switch response {
            case .success(let result):
                if result.code == 201 {
                    UserDefaultsManager.shared().token = result.data?.accessToken
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
    private func bookWithRegister(userData: UserData) {
        self.view?.showLoader()
        APIManager.bookWithRegsiter(userData: userData) { (response) in
            switch response {
            case .success(let result):
                if result.code == 201 {
                    UserDefaultsManager.shared().token = result.data?.accessToken
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
