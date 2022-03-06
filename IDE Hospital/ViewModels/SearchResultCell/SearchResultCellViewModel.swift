//
//  SearchResultCellViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

protocol SearchResultCellViewModelProtocol {
    func handleFavoriteTapped(id:Int, isFavorite: Bool, cell: SearchResultCell)
    func setupFavoriteImage(_ imageView: UIImageView, isFavorite: Bool)
    func goToProfile(id: Int)
}

class SearchResultCellViewModel {
    
    // MARK:- Private Properties
    private weak var view: SearchResultCellProtocol?
    
    // MARK:- Init
    init(view: SearchResultCellProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension SearchResultCellViewModel: SearchResultCellViewModelProtocol{
    func goToProfile(id: Int) {
        self.view?.goToProfile(id: id)
    }
    func setupFavoriteImage(_ imageView: UIImageView, isFavorite: Bool) {
        if isFavorite {
            imageView.image = Asset.heart.image
        }
    }
    func handleFavoriteTapped(id:Int, isFavorite: Bool , cell: SearchResultCell) {
        if UserDefaultsManager.shared().isLoggedIn {
            handleFavorites(id, cell: cell)
        } else {
            self.view?.showAlert()
        }
    }
}

//MARK:- Priavte Methods
extension SearchResultCellViewModel {
    private func handleFavorites(_ id: Int, cell: SearchResultCell){
        APIManager.handleFavorite(id: id) { (response) in
            switch response {
            case .success(_):
                self.view?.handelFavorite(id: id)
                cell.markAsForavite()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
