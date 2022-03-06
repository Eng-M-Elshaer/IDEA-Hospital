//
//  FavoriteView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import UIKit

class FavoriteView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    // MARK:- Public Methods
    func setup(){
        self.searchResultTableView.backgroundColor = .clear
        registerNib()
        setupNoResultLabel()
    }
    func showNoResult(){
        noResultLabel.isHidden = false
        searchResultTableView.isHidden = true
    }
    func showResult(){
        noResultLabel.isHidden = true
        searchResultTableView.isHidden = false
    }
    
    // MARK:- Private Methods
    private func setupNoResultLabel(){
        noResultLabel.textColor = .white
        noResultLabel.font = FontFamily.PTSans.bold.font(size: 15)
        noResultLabel.text = "No Favorite Found"
        noResultLabel.isHidden = true
    }
    private func registerNib(){
        let mainCell = UINib(nibName: CustomCells.favoriteCell, bundle:nil)
        searchResultTableView.register(mainCell, forCellReuseIdentifier: CustomCells.favoriteCell)
    }
    private func setupLabel(label: UILabel, text: String){
        label.font = FontFamily.PTSans.regular.font(size: 12)
        label.text = text
        label.textColor = .white
    }
}
