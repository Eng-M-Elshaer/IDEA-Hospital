//
//  ResetPasswordVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

protocol ResetPasswordVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(message: String)
    func showSuccess(with message: String)
}

class ResetPasswordVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var resetPasswordView: ResetPasswordView!
    
    // MARK: - Properties
    var viewModel: ResetPasswordViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordView.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
    }
    
    // MARK:- Public Methods
    class func create() -> ResetPasswordVC {
        let resetPasswordVC: ResetPasswordVC = UIViewController.create(storyboardName: Storyboards.auth, identifier: "\(ResetPasswordVC.self)")
        resetPasswordVC.viewModel = ResetPasswordViewModel(view: resetPasswordVC)
        return resetPasswordVC
    }
    
    // MARK:- Actions
    @IBAction func resetPasswordBtnTapped(_ sender: IDEHospitalButton) {
        viewModel.resetPassword(email: resetPasswordView.resetPasswordTextField.text)
    }
}

//MARK:- Conform Protocol
extension ResetPasswordVC: ResetPasswordVCProtocol {
    func showLoader() {
        resetPasswordView?.showLoader()
    }
    func hideLoader() {
        resetPasswordView?.hideLoader()
    }
    func showAlert(message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showSuccess(with message: String) {
        showAlert(type: .successButton, title: message, message: ""){
            self.dismiss(animated: true) {
                AppRoot.createRoot()
            }
        }
    }
}

// MARK:- Private Methods
extension ResetPasswordVC {
    private func setupNav(){
        setupNavigationBar()
        addBackButton()
        addSettingsButton()
        setBackgroundImage()
        setViewControllerTitle(to: L10n.resetPassword)
        tabBarController?.tabBar.isHidden = true
    }
}
