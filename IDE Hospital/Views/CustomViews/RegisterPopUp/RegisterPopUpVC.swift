//
//  RegisterPopUpVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/20/20.
//

import UIKit

protocol RegisterPopUpVCProtocol: class {
    func showLoader()
    func hideLoader()
    func showAlert(message: String)
    func showSuccess(with message: String)
}

class RegisterPopUpVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var registerPopUpView: RegisterPopUpView!
    
    // MARK: - Properties
    var viewModel: RegisterPopUpViewModelProtocol!
    var timestamp: String!
    var doctorID: Int!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPopUpView.setup()
        self.viewModel = RegisterPopUpViewModel(view: self)
    }
    
    // MARK:- Actions
    @IBAction func crossBtnTapped(_ sender: UIButton) {
        dismissPopup()
    }
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        registerPopUpView.registerBtnTapped()
    }
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        registerPopUpView.loginBtnTapped()
    }
    @IBAction func signBtnTapped(_ sender: UIButton) {
        signTapped()
    }
    @IBAction func termBtnTapped(_ sender: UIButton) {
        let vc = StaticContentVC.create(type: .termsAndConditions)
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func checkBoxBtnTapped(_ sender: UIButton) {
        registerPopUpView.setupCheckBox(tag: sender.tag)
    }
}

// MARK:- Private Methods
extension RegisterPopUpVC {
    private func dismissPopup() {
        view.removeFromSuperview()
        removeFromParent()
    }
    private func signTapped(){
        let state = registerPopUpView.getPopUpState()
        let isBooked = registerPopUpView.isBookForOther
        let isHaveVoucher = registerPopUpView.isHaveVoucher
        viewModel.getUserData(name: registerPopUpView.nameTextField.text, email: registerPopUpView.emailTextField.text, mobile: registerPopUpView.phoneTextField.text, password: registerPopUpView.passwordTextField.text, timeStamp: timestamp, doctorID: doctorID, code: registerPopUpView.codeTextField.text, otherName: registerPopUpView.bookTextField.text, state: state, isHaveVoucher: isHaveVoucher, isBookForOther: isBooked)
    }
}

//MARK:- Conform Protocol
extension RegisterPopUpVC: RegisterPopUpVCProtocol {
    func showLoader() {
        registerPopUpView?.showLoader()
    }
    func hideLoader() {
        registerPopUpView?.hideLoader()
    }
    func showAlert(message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showSuccess(with message: String) {
        showAlert(type: .successButton, title: "Success", message: message){
            self.dismiss(animated: true) {
                self.dismissPopup()
            }
        }
    }
}
