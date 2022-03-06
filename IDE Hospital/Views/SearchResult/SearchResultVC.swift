//
//  SearchResultVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

protocol SearchResultVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func updateTableView()
    func showAlert(message: String)
    func showResult(state: ResultState)
}

class SearchResultVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var searchResultView: SearchResultView!
    
    // MARK: - Properties
    var viewModel: SearchResultViewModelProtocol!
        
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.setup()
        setupTableViewDelegates()
        setupPickers()
        self.setBackgroundImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
        viewModel.getResultData()
    }
    
    // MARK:- Public Methods
    class func create(queryData: DoctorsQuery) -> SearchResultVC {
        let searchResultVC: SearchResultVC = UIViewController.create(storyboardName: Storyboards.main, identifier: "\(SearchResultVC.self)")
        searchResultVC.viewModel = SearchResultViewModel(view: searchResultVC, queryData: queryData)
        return searchResultVC
    }
}

// MARK: - CollectionView DataSource
extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDoctorListCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultView?.searchResultTableView.dequeueReusableCell(withIdentifier: CustomCells.searchResultCell, for: indexPath) as! SearchResultCell
        let result = viewModel.getDoctorResultData(for: indexPath.item)
        cell.cellConfig(result: result)
        cell.result = result
        cell.viewModel = SearchResultCellViewModel(view: self)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getDoctorListCount() - 1 {
            viewModel.getNextPaginationPage()
        }
    }
}

// MARK:- Private Methods
extension SearchResultVC {
    private func setupTableViewDelegates(){
        searchResultView.searchResultTableView.delegate = self
        searchResultView.searchResultTableView.dataSource = self
    }
    private func setupPickers() {
        searchResultView.pickerView.dataSource = self
        searchResultView.pickerView.delegate = self
        searchResultView.sortValueTextField.inputView = searchResultView.pickerView
        searchResultView.sortValueTextField.inputAccessoryView = setupPickerToolbar()
    }
    private func setupPickerToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelHandler))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(doneHandler))
        toolbar.setItems([cancelButton, flexButton, doneButton], animated: false)

        return toolbar
    }
    @objc private func doneHandler() {
        let picker = searchResultView.sortValueTextField.inputView as! UIPickerView
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selection = searchResultView.sortTypes[selectedRow]
        searchResultView.sortValueTextField.text = selection
        viewModel.setSortBy(selection)
        searchResultView.sortValueTextField.resignFirstResponder()
        picker.selectRow(0, inComponent: 0, animated: false)
    }
    @objc private func cancelHandler() {
        searchResultView.sortValueTextField.resignFirstResponder()
    }
    private func setupNav(){
        setupNavigationBar()
        setViewControllerTitle(to: L10n.searchResult)
        addSettingsButton()
        addBackButton()
    }
}

//MARK:- Conform Protocol
extension SearchResultVC: SearchResultVCProtocol {
    func updateTableView() {
        searchResultView.searchResultTableView.reloadData()
    }
    func showAlert(message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showLoader() {
        searchResultView?.showLoader()
    }
    func hideLoader() {
        searchResultView?.hideLoader()
    }
    func showResult(state: ResultState) {
        switch state {
        case .found:
            searchResultView?.showResult()
        case .notFound:
            searchResultView?.showNoResult()
        }
    }
}

//MARK:- SearchResultCellDelegate
extension SearchResultVC: SearchResultCellDelegate {
    func favoriteBtnTapped(_ searchCell: SearchResultCell, favoriteButtonTappedFor result: DoctorProfile) {
        searchCell.viewModel.handleFavoriteTapped(id: result.id ?? 1, isFavorite: result.isFavorited ?? false, cell: searchCell)
    }
    func bookNowBtnTapped(_ searchCell: SearchResultCell, bookNowBtnTappedFor result: DoctorProfile) {
        searchCell.viewModel.goToProfile(id: result.id ?? 1)
    }
}

//MARK:- SearchResultCellProtocol
extension SearchResultVC: SearchResultCellProtocol {
    func showAlert() {
        self.showAlert(type: .failButton, title: L10n.sorry, message: L10n.plaeseLoginFirst)
    }
    func goToProfile(id: Int) {
        let doctorVC = DrProfileVC.create(id: id)
        navigationController?.pushViewController(doctorVC, animated: true)
    }
    func handelFavorite(id: Int) {
        self.viewModel.updatetDoctorFavorite(id: id)
    }
}

// MARK:- UIPickerViewDataSource, UIPickerViewDelegate
extension SearchResultVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchResultView.sortTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return searchResultView.sortTypes[row]
    }
}
