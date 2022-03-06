//
//  SignUpVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

protocol SignUpVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(message: String)
    func showSuccess(with message: String)
}

class SignUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var signUpView: SignUpView!
    
    // MARK: - Properties
    var viewModel: SignUpViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.auth, identifier: "\(SignUpVC.self)")
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
    
    // MARK:- Actions
    @IBAction func signUpBtnTapped(_ sender: IDEHospitalButton) {
        viewModel.getUserData(name: signUpView.nameTextField.text, email: signUpView.emailTextField.text, mobile: signUpView.phoneTextField.text, password: signUpView.passwordTextField.text, confrimPassword: signUpView.confirmPasswordTextField.text)
    }
    @IBAction func termBtnTapped(_ sender: UIButton) {
        let vc = StaticContentVC.create(type: .termsAndConditions)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Conform Protocol
extension SignUpVC: SignUpVCProtocol {
    func showLoader() {
        signUpView?.showLoader()
    }
    func hideLoader() {
        signUpView?.hideLoader()
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
extension SignUpVC {
    private func setupNav(){
        setupNavigationBar()
        addBackButton()
        addSettingsButton()
        setBackgroundImage()
        setViewControllerTitle(to: L10n.signUp)
        tabBarController?.tabBar.isHidden = true
    }
}
