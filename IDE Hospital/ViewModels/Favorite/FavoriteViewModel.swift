//
//  FavoriteViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func getFavorites() -> [DoctorProfile]
    func getFavoritesResultData(for item: Int) -> DoctorProfile
    func updateFavorites(id: Int)
    func getFavoritesCount() -> Int
    func didTapBack()
    func getNextPaginationPage()
    func getFavoritesList()
    func setupTabBar()
}

class FavoriteViewModel {
    
    // MARK:- Private Properties
    private weak var view: FavoriteVCProtocol?
    private var favorites = [DoctorProfile]()
    private var comeFrom: ComeFrom!
    private var paginationPageNumber: Int!
    private var lastPaginationPage: Int!

    // MARK:- Init
    init(view: FavoriteVCProtocol, comeFrom: ComeFrom) {
        self.view = view
        self.comeFrom = comeFrom
    }
}

//MARK:- Conform Protocol
extension FavoriteViewModel: FavoriteViewModelProtocol {
    func getNextPaginationPage() {
        if paginationPageNumber < lastPaginationPage {
            paginationPageNumber += 1
            getListData()
        }
    }
    func updateFavorites(id: Int) {
        let filteredProdcutIndex = self.favorites.enumerated().filter({ $0.element.id == id}).map({ $0.offset })
        favorites.remove(at: filteredProdcutIndex[0])
        self.view?.updateTableView()
    }
    func getFavoritesResultData(for item: Int) -> DoctorProfile {
        return favorites[item]
    }
    func getFavorites() -> [DoctorProfile] {
        return favorites
    }
    func getFavoritesCount() -> Int {
        return favorites.count
    }
    func didTapBack() {
        switch comeFrom {
        case .settings:
            self.view?.goBack()
        default:
            self.view?.goToRoot()
        }
    }
    func getFavoritesList(){
        paginationPageNumber = 1
        favorites.removeAll()
        getListData()
    }
    func setupTabBar(){
        switch comeFrom {
        case .settings:
            self.view?.tabBarController?.tabBar.isHidden = true
        default:
            self.view?.tabBarController?.tabBar.isHidden = false
            self.view?.addSettingsButton()
        }
    }
}

// MARK: Call API
extension FavoriteViewModel {
    private func getListData(){
        if UserDefaultsManager.shared().isLoggedIn {
            self.view?.showLoader()
            APIManager.getFavorites(page: paginationPageNumber) { (response) in
                switch response {
                case .success(let result):
                  if result.code == 200 {
                        guard let data =  (result.data?.items) else {return}
                        self.favorites += data
                        self.lastPaginationPage = result.data?.total_pages
                        self.view?.showResult(state: .found)
                        self.view?.updateTableView()
                        if data.count == 0 {
                            self.view?.showResult(state: .notFound)
                        }
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
        } else {
            self.view?.showResult(state: .notFound)
        }
    }
}
