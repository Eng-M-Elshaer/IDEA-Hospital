//
//  RegisterPopUpView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/20/20.
//

import UIKit

class RegisterPopUpView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var loginCrossButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeButton: UIButton!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var signButton: IDEHospitalButton!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var termButton: UIButton!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    // MARK: - Properties
    var popUpState = PopUpState.register
    var isBookForOther = false
    var isHaveVoucher = false
    
    // MARK:- Public Methods
    func setup() {
        self.layoutIfNeeded()
        setupContainerView()
        setupButton(button: loginButton, text: L10n.login)
        setupButton(button: registerButton, text: L10n.register)
        setupTextFields()
        setupTextField(textField: codeTextField, text: L10n.enterCode)
        setupTextField(textField: bookTextField, text: L10n.enterName)
        setupTermLabel()
        setupTermButton()
        setupLabel(label: codeLabel, text: L10n.iHaveAVoucherCode)
        setupLabel(label: bookLabel, text: L10n.bookForAnotherPerson)
        registerBtnTapped()
        codeButton.setImage(Asset.emptyCheckBox.image, for: .normal)
        bookButton.setImage(Asset.emptyCheckBox.image, for: .normal)
        codeTextField.isEnabled = false
        bookTextField.isEnabled = false
    }
    func setupCheckBox(tag: Int){
        if tag == 0 {
          checkButton(button: codeButton)
        } else {
           checkButton(button: bookButton)
        }
    }
    func getPopUpState() -> PopUpState {
        return self.popUpState
    }
    func registerBtnTapped(){
        loginView.backgroundColor = .clear
        loginButton.tintColor = .white
        registerView.backgroundColor = .white
        registerButton.tintColor = .darkRoyalBlue
        loginCrossButton.setImage(Asset.cross.image, for: .normal)
        nameView.isHidden = false
        phoneView.isHidden = false
        signButton.setup(title: L10n.signUpBook)
        popUpState = .register
        emptyTextField()
    }
    func loginBtnTapped(){
        loginView.backgroundColor = .white
        loginButton.tintColor = .darkRoyalBlue
        registerView.backgroundColor = .clear
        registerButton.tintColor = .white
        loginCrossButton.setImage(Asset.blueCross.image, for: .normal)
        nameView.isHidden = true
        phoneView.isHidden = true
        signButton.setup(title: L10n.loginBook)
        popUpState = .login
        emptyTextField()
    }
}

// MARK:- Private Methods
extension RegisterPopUpView {
    private func checkButton(button: UIButton){
        if button.currentImage == Asset.emptyCheckBox.image {
            button.setImage(Asset.fillCheckBox.image, for: .normal)
            if button == codeButton {
                codeTextField.isEnabled = true
                isHaveVoucher = true
            } else if button == bookButton {
                bookTextField.isEnabled = true
                isBookForOther = true
            }
        } else {
            button.setImage(Asset.emptyCheckBox.image, for: .normal)
            if button == codeButton {
                codeTextField.isEnabled = false
                isHaveVoucher = false
            } else if button == bookButton {
                bookTextField.isEnabled = false
                isBookForOther = false
            }
        }
    }
    private func emptyTextField(){
        nameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        passwordTextField.text = ""
    }
    private func setupTextFields(){

        nameTextField.setupPlaceholder(text: L10n.yourName)
        
        emailTextField.setupPlaceholder(text: L10n.yourEmail)
        
        phoneTextField.setupPlaceholder(text: L10n.mobileNumber)
        phoneTextField.keyboardType = .phonePad
        
        passwordTextField.setupPlaceholder(text: L10n.enterPassword)
        passwordTextField.isSecureTextEntry = true
        
        codeTextField.keyboardType = .asciiCapableNumberPad
    }
    private func setupLabel(label: UILabel, text: String){
        label.textColor = .white
        label.font = FontFamily.PTSans.bold.font(size: 12)
        label.text = text
    }
    private func setupTextField(textField: UITextField, text: String){
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])

    }
    private func setupContainerView() {
        containerView.backgroundColor = .clear
        containerView.layer.cornerRadius = 10
        containerView.addShadow()
    }
    private func setupButton(button: UIButton, text: String){
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = FontFamily.PTSans.bold.font(size: 20)
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
        termButton.titleLabel?.adjustsFontSizeToFitWidth = true
        termButton.titleLabel?.minimumScaleFactor = 0.5
    }
}
