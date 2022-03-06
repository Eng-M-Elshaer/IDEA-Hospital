//
//  FavoriteCellViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import UIKit

protocol FavoriteCellViewModelProtocol {
    func handleFavoriteTapped(id:Int, isFavorite: Bool, cell: FavoriteCell)
    func goToProfile(id: Int)
}

class FavoriteCellViewModel {
    
    // MARK:- Private Properties
    private weak var view: FavoriteCellProtocol?
    
    // MARK:- Init
    init(view: FavoriteCellProtocol) {
        self.view = view
    }
}

//MARK:- Conform Protocol
extension FavoriteCellViewModel: FavoriteCellViewModelProtocol{
    func goToProfile(id: Int) {
        self.view?.goToProfile(id: id)
    }
    func handleFavoriteTapped(id:Int, isFavorite: Bool , cell: FavoriteCell) {
            removeFromFavorite(id)
    }
}

//MARK:- Private Methods (Call API)
extension FavoriteCellViewModel {
    private func removeFromFavorite(_ id: Int) {
        APIManager.handleFavorite(id: id) { (response) in
            switch response {
            case .success(let result):
                if result.code == 202 {
                    self.view?.handelFavorite(id: id)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
