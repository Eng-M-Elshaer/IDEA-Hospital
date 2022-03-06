//
//  SearchResultView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

class SearchResultView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var dropDownImageView: UIImageView!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var sortValueTextField: UITextField!
    @IBOutlet weak var noResultLabel: UILabel!

    // MARK: - Properties
    let pickerView = UIPickerView()
    let sortTypes = ["fees","rating"]
//    var sortTypes = ["fees","rating","distance"]

    // MARK:- Public Methods
    func setup(){
        self.searchResultTableView.backgroundColor = .clear
        setupSortView()
        setupTextField()
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
}

// MARK:- Private Methods
extension SearchResultView {
    private func setupNoResultLabel(){
        noResultLabel.textColor = .white
        noResultLabel.font = FontFamily.PTSans.bold.font(size: 15)
        noResultLabel.text = "No Results Found"
        noResultLabel.isHidden = true
    }
    private func registerNib(){
        let mainCell = UINib(nibName: CustomCells.searchResultCell, bundle:nil)
        searchResultTableView.register(mainCell, forCellReuseIdentifier: CustomCells.searchResultCell)
    }
    private func setupSortView(){
        sortView.backgroundColor = .darkRoyalBlue
        setupLabel(label: sortByLabel, text: L10n.sortBy)

    }
    private func setupLabel(label: UILabel, text: String){
        label.font = FontFamily.PTSans.regular.font(size: 12)
        label.text = text
        label.textColor = .white
    }
    private func setupTextField(){
        sortValueTextField.backgroundColor = .clear
        sortValueTextField.textColor = .white
        sortValueTextField.setupPlaceholder(text: "")
    }
}
