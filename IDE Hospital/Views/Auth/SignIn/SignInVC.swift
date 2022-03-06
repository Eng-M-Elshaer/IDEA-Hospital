//
//  SignInVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

protocol SignInVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(message: String)
    func showSuccess(with message: String)
}

class SignInVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var signInView: SignInView!
    
    // MARK: - Properties
    var viewModel: SignInViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
    }
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.auth, identifier: "\(SignInVC.self)")
        signInVC.viewModel = SignInViewModel(view: signInVC)
        return signInVC
    }
    
    // MARK:- Actions
    @IBAction func forgetPasswordBtnTapped(_ sender: UIButton) {
        let resetPasswordVC = ResetPasswordVC.create()
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    @IBAction func loginBtnTapped(_ sender: IDEHospitalButton) {
        viewModel.authWithEmail(email: signInView.emailTextField.text, password: signInView.passwordTextField.text)
    }
    @IBAction func siginUpBtnTapped(_ sender: IDEHospitalButton) {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

//MARK:- Conform Protocol
extension SignInVC: SignInVCProtocol {
    func showLoader() {
        signInView?.showLoader()
    }
    func hideLoader() {
        signInView?.hideLoader()
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
extension SignInVC {
    private func setupNav(){
        setupNavigationBar()
        addBackButton()
        addSettingsButton()
        setBackgroundImage()
        setViewControllerTitle(to: L10n.login)
        tabBarController?.tabBar.isHidden = true
    }
}
