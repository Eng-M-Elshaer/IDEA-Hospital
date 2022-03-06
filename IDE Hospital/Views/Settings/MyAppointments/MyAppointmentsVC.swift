//
//  MyAppointmentsViewController.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

protocol MyAppointmentVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func reloadTableView()
    func showError(with message: String)
    func showSuccess(with message: String)
    func openGoogleMap(lat: Float, lng: Float)
    func showResult(state: ResultState)
    func goBack()
    func goToRoot()
    func confirmDeleteAppointment()
}

class MyAppointmentsVC: UIViewController{
    
    // MARK:- Outlets
    @IBOutlet weak var myAppointmentsView: MyAppointmentsView!
    
    // MARK: - Properties
    private var viewModel: MyAppointmentsViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        myAppointmentsView.setup()
        delegates()
        setupNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getMyAppointments()
        viewModel.setupTabBar()
    }
    
    // MARK:- Actions
    override func backButtonPressAction() {
        self.viewModel.didTapBack()
    }
    
    // MARK:- Public Methods
    class func create(comeFrom: ComeFrom) -> MyAppointmentsVC {
        let myAppointmentVC: MyAppointmentsVC = UIViewController.create(storyboardName: Storyboards.settings, identifier: "\(MyAppointmentsVC.self)")
        myAppointmentVC.viewModel = MyAppointmentViewModel(view: myAppointmentVC, ComFrom: comeFrom)
        return myAppointmentVC
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension MyAppointmentsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMyAppointmentsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointment = viewModel.getAppointment(at: indexPath.row)
        guard let appointmentCell = tableView.dequeueReusableCell(withIdentifier: MyAppointmentsTableViewCell.ID, for: indexPath) as? MyAppointmentsTableViewCell else {return UITableViewCell()}
        appointmentCell.configure(myAppointment: appointment, index: indexPath.row)
        appointmentCell.delegate = self
        return appointmentCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMyAppointmentsCount() - 1 {
            viewModel.getNextPaginationPage()
        }
    }
}

//MARK:- Conform Protocol
extension MyAppointmentsVC: MyAppointmentVCProtocol{
    func confirmDeleteAppointment() {
        showAlert(type: .twoButtons, title: L10n.areYouSureYouWantToCancelAppointment, message: L10n.cancelAppointmentNote, buttonTitle: L10n.yes) {
            self.viewModel.deleteAppointment()
            self.dismiss(animated: true, completion: nil)
        }
    }
    func showResult(state: ResultState) {
        switch state {
        case .found:
            myAppointmentsView?.showResult()
        case .notFound:
            myAppointmentsView?.showNoResult()
        }
    }
    func openGoogleMap(lat: Float, lng: Float) {
        AppUtility.openGoogleMap(lat: lat, lng: lng)
    }
    func showLoader() {
        self.myAppointmentsView.showLoader()
    }
    func hideLoader() {
        self.myAppointmentsView.hideLoader()
    }
    func reloadTableView() {
        self.myAppointmentsView.tableView.reloadData()
    }
    func showError(with message: String) {
        showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showSuccess(with message: String) {
        showAlert(type: .successButton, title: message, message: ""){
            self.dismiss(animated: true) {
                self.viewModel.getMyAppointments()
            }
        }
    }
    func goBack() {
        self.backButtonPressed()
    }
    func goToRoot() {
        let window: UIWindow? = UIApplication.shared.windows.first
        let mainVC: MainVC = MainVC.create()
        let mainNavigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = mainNavigationController
    }
}

// MARK:- Private Methods
extension MyAppointmentsVC {
    private func delegates() {
        myAppointmentsView.tableView.dataSource = self
        myAppointmentsView.tableView.delegate = self
    }
    private func setupNavBar(){
        setBackgroundImage()
        setupNavigationBar()
        setViewControllerTitle(to: L10n.myAppointment)
        addBackTooRootButton()
    }
}

//MARK:- Appointment cell Delegate
extension MyAppointmentsVC: MyAppointmentCellDelegate{
    func deleteAppointment(at index: Int) {
        self.viewModel.deleteAppointment(at: index)
    }
    func viewMap(at index: Int) {
        self.viewModel.viewDoctorLocation(at: index)
    }
}
