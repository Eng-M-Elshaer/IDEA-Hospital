//
//  FavoriteVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import UIKit

enum ResultState {
    case found
    case notFound
}

protocol FavoriteVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func updateTableView()
    func showAlert(message: String)
    func showResult(state: ResultState)
    func goBack()
    func goToRoot()
}

class FavoriteVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var favoriteView: FavoriteView!
    
    // MARK: - Properties
    var viewModel: FavoriteViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteView.setup()
        setupTableViewDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getFavoritesList()
        setupNav()
        viewModel.setupTabBar()
    }
    
    // MARK:- Public Methods
    class func create(comeFrom: ComeFrom) -> FavoriteVC {
        let favoriteVC: FavoriteVC = UIViewController.create(storyboardName: Storyboards.favorite, identifier: "\(FavoriteVC.self)")
        favoriteVC.viewModel = FavoriteViewModel(view: favoriteVC, comeFrom: comeFrom)
        return favoriteVC
    }
    
    // MARK:- Actions
    override func backButtonPressAction() {
        self.viewModel.didTapBack()
    }
}

// MARK: - UITableViewDelegate DataSource
extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFavoritesCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteView?.searchResultTableView.dequeueReusableCell(withIdentifier: CustomCells.favoriteCell, for: indexPath) as! FavoriteCell
        let result = viewModel.getFavoritesResultData(for: indexPath.item)
        cell.cellConfig(result: result)
        cell.result = result
        cell.viewModel = FavoriteCellViewModel(view: self)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getFavoritesCount() - 1 {
            viewModel.getNextPaginationPage()
        }
    }
}

// MARK:- Private Methods
extension FavoriteVC {
    private func setupTableViewDelegates(){
        favoriteView.searchResultTableView.delegate = self
        favoriteView.searchResultTableView.dataSource = self
    }
    private func setupNav(){
        setupNavigationBar()
        setViewControllerTitle(to: L10n.myFavorites)
        addBackTooRootButton()
        self.setBackgroundImage()
    }
}

//MARK:- Conform Protocol
extension FavoriteVC: FavoriteVCProtocol {
    func showResult(state: ResultState) {
        switch state {
        case .found:
            favoriteView?.showResult()
        case .notFound:
            favoriteView?.showNoResult()
        }
    }
    func updateTableView() {
        favoriteView?.searchResultTableView.reloadData()
    }
    func goBack() {
        self.backButtonPressed()
    }
    func goToRoot() {
        AppRoot.createRoot()
    }
    func showAlert(message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showLoader() {
        favoriteView?.showLoader()
    }
    func hideLoader() {
        favoriteView?.hideLoader()
    }
}
//MARK:- FavoriteCellDelegate
extension FavoriteVC: FavoriteCellDelegate {
    func favoriteBtnTapped(_ favoriteCell: FavoriteCell, favoriteButtonTappedFor result: DoctorProfile) {
        favoriteCell.viewModel.handleFavoriteTapped(id: result.id ?? 1, isFavorite: true , cell: favoriteCell)
    }
    func viewProfileBtnTapped(_ favoriteCell: FavoriteCell, viewProfileBtnTappedFor result: DoctorProfile) {
        favoriteCell.viewModel.goToProfile(id: result.id ?? 1)
    }
}

//MARK:- Conform Protocol
extension FavoriteVC: FavoriteCellProtocol {
    func handelFavorite(id: Int) {
        self.viewModel.updateFavorites(id: id)
    }
    func goToProfile(id: Int) {
        let doctorVC = DrProfileVC.create(id: id)
        navigationController?.pushViewController(doctorVC, animated: true)
    }
}
