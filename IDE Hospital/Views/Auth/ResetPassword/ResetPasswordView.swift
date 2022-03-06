//
//  ResetPasswordView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

class ResetPasswordView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var resetPasswordTextField: IDEHospitalTextField!
    @IBOutlet weak var resetPasswordButton: IDEHospitalButton!
    
    // MARK:- Public Methods
    func setup(){
        self.layoutIfNeeded()
        resetPasswordButton.setup(title: L10n.setNewPassword)
        resetPasswordTextField.addLineView()
        resetPasswordTextField.addImage(image: Asset.email.image)
        resetPasswordTextField.setupPlaceholder(text: L10n.yourEmail)
    }
}
