//
//  SignUpView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

class SignUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var nameTextField: IDEHospitalTextField!
    @IBOutlet weak var emailTextField: IDEHospitalTextField!
    @IBOutlet weak var phoneTextField: IDEHospitalTextField!
    @IBOutlet weak var passwordTextField: IDEHospitalTextField!
    @IBOutlet weak var confirmPasswordTextField: IDEHospitalTextField!
    @IBOutlet weak var signUpButton: IDEHospitalButton!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var termButton: UIButton!
    
    // MARK:- Public Methods
    func setup(){
        self.layoutIfNeeded()
        setupTextFields()
        signUpButton.setup(title: L10n.signUp)
        setupTermLabel()
        setupTermButton()
    }
    
    // MARK:- Private Methods
    private func setupTextFields(){
        nameTextField.addLineView()
        nameTextField.addImage(image: Asset.user.image)
        nameTextField.setupPlaceholder(text: L10n.yourName)
        
        emailTextField.addLineView()
        emailTextField.addImage(image: Asset.email.image)
        emailTextField.setupPlaceholder(text: L10n.yourEmail)
        
        phoneTextField.addLineView()
        phoneTextField.addImage(image: Asset.phone.image)
        phoneTextField.setupPlaceholder(text: L10n.mobileNumber)
        phoneTextField.keyboardType = .namePhonePad
        
        passwordTextField.addLineView()
        passwordTextField.addImage(image: Asset.password.image)
        passwordTextField.setupPlaceholder(text: L10n.choosePassword)
        passwordTextField.isSecureTextEntry = true
        
        confirmPasswordTextField.addLineView()
        confirmPasswordTextField.addImage(image: Asset.password.image)
        confirmPasswordTextField.setupPlaceholder(text: L10n.confirmPassword)
        confirmPasswordTextField.isSecureTextEntry = true

    }
    private func setupTermLabel(){
        termLabel.font = FontFamily.PTSans.regular.font(size: 12)
        termLabel.textColor = .white
        termLabel.text = L10n.byClickingSignUpYouAgreeToOur
    }
    private func setupTermButton(){
        termButton.layer.borderWidth = 0.0
        let attributedString = NSAttributedString(string: L10n.termsConditions, attributes:[
            NSAttributedString.Key.font : FontFamily.PTSans.bold.font(size: 12),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        termButton.setAttributedTitle(attributedString, for: .normal)
    }
}
