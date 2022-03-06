//
//  InfosViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import Foundation

enum StaticContentType{
    case aboutus
    case termsAndConditions
}

protocol StaticContentViewModelProtocol {
    func setup()
    func getTitle()-> String
}

class StaticContentViewModel{
    
    // MARK:- Private Properties
    private weak var view: StaticContentVCProtocol?
    private var type : StaticContentType!
    
    // MARK:- Init
    init(view: StaticContentVCProtocol, type: StaticContentType){
        self.view = view
        self.type = type
    }
}

//MARK:- Conform Protocol
extension StaticContentViewModel: StaticContentViewModelProtocol{
    func setup() {
        self.callAPI(type: type)
    }
    func getTitle() -> String {
        switch type {
        case .aboutus:
            return L10n.aboutUS
        default:
            return L10n.termsAndConditions
        }
    }
}

//MARK:- API
extension StaticContentViewModel{
    private func callAPI(type: StaticContentType){
        switch type {
        case .aboutus:
            self.getAboutUs()
        default:
            self.getTerms()
        }
    }
    private func getAboutUs() {
        self.view?.showLoader()
        APIManager.getAboutus { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 200:
                    if let data = response.data{
                        
                        self.view?.showText(text: data.aboutUs?.htmlToString ?? "")
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.handleError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.handleError(with: error.localizedDescription)
            }
        }
        self.view?.hideLoader()
    }
    private func getTerms() {
        self.view?.showLoader()
        APIManager.getTerms { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 200:
                    if let data = response.data{
                        
                        self.view?.showText(text: data.termsAndConditions?.htmlToString ?? "")
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.handleError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.handleError(with: error.localizedDescription)
            }
        }
        self.view?.hideLoader()
    }
}
