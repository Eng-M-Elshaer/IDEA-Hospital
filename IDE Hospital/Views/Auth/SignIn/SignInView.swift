//
//  SignInView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

class SignInView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var emailTextField: IDEHospitalTextField!
    @IBOutlet weak var passwordTextField: IDEHospitalTextField!
    @IBOutlet weak var signInButton: IDEHospitalButton!
    @IBOutlet weak var forrgetPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: IDEHospitalButton!
    @IBOutlet weak var accoutLabel: UILabel!
    
    // MARK:- Public Methods
    func setup(){
        self.layoutIfNeeded()
        setupTextFiels()
        signInButton.setup(title: L10n.login)
        setupButtons()
        setupAccountLabel()
        setupForrgetPasswordButton()
    }
    
    // MARK:- Private Methods
    private func setupTextFiels(){
        emailTextField.addLineView()
        emailTextField.addImage(image: Asset.email.image)
        emailTextField.setupPlaceholder(text: L10n.yourEmail)
        
        passwordTextField.addLineView()
        passwordTextField.addImage(image: Asset.password.image)
        passwordTextField.setupPlaceholder(text: L10n.enterPassword)
        passwordTextField.isSecureTextEntry = true
    }
    private func setupButtons(){
        signInButton.setup(title: L10n.login)
        signUpButton.setup(title: L10n.signUp)
        signUpButton.backgroundColor = .steelGrey
    }
    private func setupAccountLabel(){
        accoutLabel.font = FontFamily.PTSans.regular.font(size: 12)
        accoutLabel.textColor = .white
        accoutLabel.text = L10n.donTHaveAccount
    }
    private func setupForrgetPasswordButton(){
        forrgetPasswordButton.layer.borderWidth = 0.0
        let attributedString = NSAttributedString(string: L10n.forgotPassword, attributes:[
            NSAttributedString.Key.font : FontFamily.PTSans.bold.font(size: 15),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        forrgetPasswordButton.setAttributedTitle(attributedString, for: .normal)
    }
}
