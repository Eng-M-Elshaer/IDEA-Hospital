//
//  DrProfileViewController.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import UIKit

protocol DrProfileViewControllerProtocol: UIViewController {
    func showLoader(type: LoaderType)
    func hideLoader(type: LoaderType)
    func showError(with message: String)
    func showVoucher()
    func showConfirm(with message: String)
    func showSuccess(with message: String)
    func reloadAppointmentsCollectionView()
    func reloadReviewTableView()
    func setupDrProfile(profile: DoctorProfile)
    func setupAppoinmentDate(appointment: AppointmentDate)
    func goToReviewVC(id: Int)
    func openMap(lat: Float, lng: Float)
    func showSignin(timeStamp: String, doctorID: Int)
    func showResult(state: ResultState)
}

class DrProfileVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var drProfileView: DrProfileView!
    
    // MARK: - Properties
    var viewModel: DrProfileviewModelProtocol!
    static let ID = "\(DrProfileVC.self)"

    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        drProfileView.setupUI()
        setupNavBar()
        self.viewModel.getDrAppointmentsData()
        delegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getDrProfileData()
        viewModel.getReview()
    }
    
    // MARK:- Public Methods
    class func create(id: Int) -> DrProfileVC {
        let drProfileVC: DrProfileVC = UIViewController.create(storyboardName: Storyboards.drProfile, identifier: self.ID)
        drProfileVC.viewModel = DrProfileViewModel(view: drProfileVC, id: id)
        return drProfileVC
    }
    
    // MARK:- Actions
    @IBAction func favoritePressedBtn(_ sender: UIButton) {
        viewModel.didTapFavourite()
    }
    @IBAction func tapReviewPressedBtn(_ sender: UIButton) {
        viewModel.didTapReview()
    }
    @IBAction func nextDatePressedBtn(_ sender: UIButton) {
        viewModel.didTapNext()
    }
    @IBAction func previousDatePressedBtn(_ sender: UIButton) {
        viewModel.didTapPrevious()
    }
    
    @IBAction func openMapBtnPressed(_ sender: UIButton) {
        viewModel.didTapViewOnMap()
    }
    @IBAction func bookPressedBtn(_ sender: UIButton) {
        viewModel.didTapBook()
    }
    @IBAction func doctorPorfilePressedBtn(_ sender: UIButton) {
        self.drProfileView.setupDoctorProfileButton()
    }
    @IBAction func reviewsPressedBtn(_ sender: UIButton) {
        self.drProfileView.setupReviewsButton()
    }
}

// MARK:- UICollectionViewDataSource, UICollectionViewDelegate
extension DrProfileVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.appoinmentTimesCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let time = viewModel.getAppointmentTimes(at: indexPath.row)
        guard let timeCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.ID, for: indexPath) as? TimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        timeCell.configure(time: time)
        return timeCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapAppointmentTime(at: indexPath.row)
        self.drProfileView.setupBook()
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension DrProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = viewModel.getReviews(at: indexPath.row)
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.ID, for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
        reviewCell.configure(review: review)
        return reviewCell
    }
}

//MARK:- Conform Protocol
extension DrProfileVC: DrProfileViewControllerProtocol{
    func showResult(state: ResultState) {
        switch state {
        case .found:
            self.drProfileView.showResult()
        default:
            self.drProfileView.showNoResult()
        }
    }
    func openMap(lat: Float, lng: Float) {
        AppUtility.openGoogleMap(lat: lat, lng: lng)
    }
    func showLoader(type: LoaderType) {
        switch type {
        case .profile:
            self.drProfileView.showLoader()
            break
        case .appointments:
            self.drProfileView.appointmentsCollectionView.showLoader()
            break
        
        default:
            self.drProfileView.reviewTableView.showLoader()
            break
        }
    }
    func hideLoader(type: LoaderType) {
        switch type {
        case .profile:
            self.drProfileView.hideLoader()
            break
        case .appointments:
            self.drProfileView.appointmentsCollectionView.hideLoader()
            break
        
        default:
            self.drProfileView.reviewTableView.hideLoader()
            break
        }
    }
    func showError(with message: String) {
        self.showAlert(type: .failButton, title: message, message: "")
    }
    func showVoucher() {
        let voucher = VoucherViewController.create()
        voucher.delegate = self
        voucher.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        voucher.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(voucher, animated: true, completion: nil)
    }
    func showConfirm(with message: String) {
        self.showAlert(type: .confirmButton, title: L10n.confirmYourAppointment, message: message, buttonTitle: L10n.confirm) {
            self.dismiss(animated: true) {
                self.viewModel.booknow()
            }
        }
    }
    func showSuccess(with message: String) {
        self.showAlert(type: .successButton, title: message, message: ""){
            self.dismiss(animated: true) {
                self.viewModel.getDrAppointmentsData()
            }
        }
    }
    func goToReviewVC(id: Int) {
        let reviewVC = ReviewVC.create(id: id)
        self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    func setupAppoinmentDate(appointment: AppointmentDate) {
        self.drProfileView.setupAppointmentLabel(appointment: appointment)
    }
    func reloadAppointmentsCollectionView() {
        self.drProfileView.appointmentsCollectionView.reloadData()
        self.drProfileView.setupUnbooked()
        self.drProfileView.appointmentsCollectionView.setContentOffset(.zero, animated: true)
    }
    func reloadReviewTableView() {
        self.drProfileView.reviewTableView.reloadData()
    }
    func setupDrProfile(profile: DoctorProfile) {
        drProfileView.setup(drProfile: profile)
    }
    func showSignin(timeStamp: String, doctorID: Int) {
        self.showRegPopup(timeStamp: timeStamp, doctorID: doctorID)
    }
}

// MARK:- Private Methods
extension DrProfileVC{
    private func delegates(){
        self.drProfileView.appointmentsCollectionView.delegate = self
        self.drProfileView.appointmentsCollectionView.dataSource = self
        self.drProfileView.reviewTableView.delegate = self
        self.drProfileView.reviewTableView.dataSource = self
    }
    private func setupNavBar(){
        setupNavigationBar()
        setViewControllerTitle(to: L10n.searchResult)
        addBackButton()
        addSettingsButton()
        setBackgroundImage()
    }
}

// MARK:- VoucherDelegate
extension DrProfileVC: VoucherDelegate{
    func voucherCode(code: String, patientName: String) {
        self.viewModel.getVoucher(voucher: code, patientName: patientName)
    }
}
