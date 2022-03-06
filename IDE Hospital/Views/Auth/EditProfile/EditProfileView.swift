//
//  EditProfileView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

class EditProfileView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var nameTextField: IDEHospitalTextField!
    @IBOutlet weak var emailTextField: IDEHospitalTextField!
    @IBOutlet weak var phoneTextField: IDEHospitalTextField!
    @IBOutlet weak var oldPasswordTextField: IDEHospitalTextField!
    @IBOutlet weak var newPasswordTextField: IDEHospitalTextField!
    @IBOutlet weak var confirmPasswordTextField: IDEHospitalTextField!
    @IBOutlet weak var saveButton: IDEHospitalButton!
    @IBOutlet weak var cancelButton: IDEHospitalButton!
    @IBOutlet weak var contanierView: UIView!
    
    // MARK:- Public Methods
    func setup(){
        contanierView.layoutIfNeeded()
        setupTextFields()
        setupButtons()
    }
    func setData(user: Register) {
        nameTextField.text = user.name
        emailTextField.text = user.email
        phoneTextField.text = user.mobile
        oldPasswordTextField.text = "abcdABCD1234"
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
        phoneTextField.keyboardType = .phonePad
        
        oldPasswordTextField.addLineView()
        oldPasswordTextField.addImage(image: Asset.password.image)
        oldPasswordTextField.setupPlaceholder(text: L10n.oldPassword)
        oldPasswordTextField.isSecureTextEntry = true
        
        newPasswordTextField.addLineView()
        newPasswordTextField.addImage(image: Asset.password.image)
        newPasswordTextField.setupPlaceholder(text: L10n.setNewPassword)
        newPasswordTextField.isSecureTextEntry = true
        
        confirmPasswordTextField.addLineView()
        confirmPasswordTextField.addImage(image: Asset.password.image)
        confirmPasswordTextField.setupPlaceholder(text: L10n.confirmPassword)
        confirmPasswordTextField.isSecureTextEntry = true
    }
    private func setupButtons(){
        saveButton.setup(title: L10n.save, fontSize: 15)
        cancelButton.setup(title: L10n.cancel, fontSize: 15)
        cancelButton.backgroundColor = .richPurple
    }
}
