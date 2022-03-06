//
//  MainViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

protocol MainViewModelProtocol {
    func getMainCategories() -> [MainCategories]
    func getMainData()
    func getMainCategoreData(for item: Int) -> MainCategories
    func getMainCategoriesCount() -> Int
}

class MainViewModel {
    
    // MARK:- Private Properties
    private weak var view: MainVCProtocol?
    private var mainCategories = [MainCategories]()

    // MARK:- Init
    init(view: MainVCProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension MainViewModel: MainViewModelProtocol {
    func getMainCategoreData(for item: Int) -> MainCategories {
        return mainCategories[item]
    }
    func getMainCategoriesCount() -> Int {
        return mainCategories.count
    }
    func getMainCategories() -> [MainCategories] {
        return mainCategories
    }
    func getMainData(){
        self.view?.showLoader()
        APIManager.getMainCategories { (response) in
            switch response {
            case .success(let result):
                if result.code == 200 {
                    self.mainCategories = result.data!
                    self.view?.reloadCollectionView()
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
