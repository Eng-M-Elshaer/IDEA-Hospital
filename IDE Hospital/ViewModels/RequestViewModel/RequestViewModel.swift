//
//  RequestViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/21/20.
//

import Foundation

protocol RequestViewModelProtocol {
    func getRequestData(name: String?, email: String?, mobile: String?,message: String?)
    func requestType()-> RequestType
    func navigationTitle()-> String
    func textViewPlaceholder()-> String
}

class RequestViewModel{
    
    // MARK:- Private Properties
    private weak var view: RequestVCProtocol?
    private var type: RequestType!
    
    // MARK:- Init
    init(view: RequestVCProtocol, type: RequestType) {
        self.view = view
        self.type = type
    }
}

//MARK:- Conform Protocol
extension RequestViewModel: RequestViewModelProtocol{
    func getRequestData(name: String?, email: String?, mobile: String?,message: String?) {
        if  vaildFields(name: name, email: email, mobile: mobile,message: message) {
            let requestData = RequestBodyData(name: name, mobile: mobile, email: email, message: message)
            sendRequest(request: requestData)
        }
    }
    func navigationTitle() -> String {
        switch type {
        case .contactus:
            return L10n.contactUs.capitalized
        default:
            return L10n.homeNurse
        }
    }
    func requestType() -> RequestType {
        return self.type
    }
    func textViewPlaceholder() -> String {
        switch type {
        case .contactus:
            return L10n.yourMessage
        default:
            return L10n.enterDetails
        }
    }
}

//MARK:- APIs
extension RequestViewModel{
    private func sendRequest(request: RequestBodyData) {
            switch type {
            case .contactus:
                self.sendContactUs(requestData: request)
            default:
                self.sendNurse(requestData: request)
            }
    }
    private func sendContactUs(requestData: RequestBodyData){
        self.view?.showLoader()
        APIManager.sendContactUs(requestData: requestData) { (response) in
            switch response{
            case .success(let result):
                switch result.code {
                case 202:
                    self.view?.showSuccess(with: L10n.requestSuccess)
                default:
                    self.view?.showError(with: result.message ?? "")
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
    
    private func sendNurse(requestData: RequestBodyData){
        self.view?.showLoader()
        APIManager.sendNurseRequest(requestData: requestData) { (response) in
            switch response{
            case .success(let result):
                switch result.code {
                case 202:
                    self.view?.showSuccess(with: L10n.requestSuccess)
                default:
                    self.view?.showError(with: result.message ?? "")
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
}

//MARK:- Validation
extension RequestViewModel{
    private func vaildFields(name: String?, email: String?, mobile: String?,message: String?) -> Bool {
        if name.isBlank {
            self.view?.showError(with: L10n.nameValidation)
            return false
        }
        if email.isBlank {
            self.view?.showError(with: L10n.emailValidation)
            return false
        }
        if !Validator.shared().isValid(entry: email!, type: .email){
            self.view?.showError(with: L10n.enterValidEmail)
            return false
        }
        if mobile.isBlank {
            self.view?.showError(with: L10n.mobileValidation)
            return false
        }
        if !Validator.shared().isValid(entry: mobile!, type: .mobile){
            self.view?.showError(with: L10n.enterValidMobile)
            return false
        }
        if message == self.textViewPlaceholder() {
            self.view?.showError(with: L10n.messageValidation)
            return false
        }
        return true
    }
}
