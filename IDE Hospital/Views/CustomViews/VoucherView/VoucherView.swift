//
//  VoucherView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/21/20.
//

import UIKit

class VoucherView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var switchVoucherButton: UISwitch!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var underlineNameView: UIView!
    @IBOutlet weak var nonameLabel: UILabel!
    @IBOutlet weak var yesNameLabel: UILabel!
    @IBOutlet weak var switchNameButton: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var continueToConfirmBtnOutlet: IDEHospitalButton!

    // MARK:- Public Methods
    func setup(){
        self.setupLabels()
        self.setupVoucherSwitch(on: true)
        setupNameSwitch(on: true)
        self.setupButton()
        self.setupButton()
        self.setupTextField()
        setupContainerView()
    }
    func setupVoucherSwitch(on: Bool){
        switchVoucherButton.isOn = on
        switchVoucherButton.tintColor = .gray
        switchVoucherButton.onTintColor = .darkRoyalBlue
        if on {
            self.codeTextField.isUserInteractionEnabled = on
            self.codeTextField.isHidden = !on
        }else {
            self.codeTextField.isUserInteractionEnabled = on
            self.codeTextField.isHidden = !on
            
        }
    }
    func setupNameSwitch(on: Bool){
        switchNameButton.isOn = on
        switchNameButton.tintColor = .gray
        switchNameButton.onTintColor = .darkRoyalBlue
        if on {
            self.nameTextField.isUserInteractionEnabled = on
            self.nameTextField.isHidden = !on
        }else {
            self.nameTextField.isUserInteractionEnabled = on
            self.nameTextField.isHidden = !on
        }
    }
}

// MARK:- Private Methods
extension VoucherView{
    private func setupContainerView(){
        self.containerView.layer.cornerRadius = 10
    }
    private func setupLabels(){
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkRoyalBlue
        titleLabel.text = L10n.doYouHaveVoucherCode
        titleLabel.font = FontFamily.PTSans.bold.font(size: 15)
        yesLabel.textAlignment = .center
        yesLabel.textColor = .darkRoyalBlue
        yesLabel.text = L10n.yes
        yesLabel.font = FontFamily.PTSans.bold.font(size: 15)
        noLabel.textAlignment = .center
        noLabel.textColor = .darkRoyalBlue
        noLabel.text = L10n.no
        noLabel.font = FontFamily.PTSans.bold.font(size: 15)
        underlineView.backgroundColor = .darkRoyalBlue
        titleNameLabel.textAlignment = .center
        titleNameLabel.textColor = .darkRoyalBlue
        titleNameLabel.text = L10n.areYouBookingForAnotherPerson
        titleNameLabel.font = FontFamily.PTSans.bold.font(size: 15)
        yesNameLabel.textAlignment = .center
        yesNameLabel.textColor = .darkRoyalBlue
        yesNameLabel.text = L10n.yes
        yesNameLabel.font = FontFamily.PTSans.bold.font(size: 15)
        nonameLabel.textAlignment = .center
        nonameLabel.textColor = .darkRoyalBlue
        nonameLabel.text = L10n.no
        nonameLabel.font = FontFamily.PTSans.bold.font(size: 15)
        underlineNameView.backgroundColor = .darkRoyalBlue
    }
    private func setupTextField(){
        codeTextField.cornerStylish(color: .darkRoyalBlue, borderWidth: 1, cornerRadius: 4)
        codeTextField.placeholder = L10n.enterCode
        nameTextField.cornerStylish(color: .darkRoyalBlue, borderWidth: 1, cornerRadius: 4)
        nameTextField.placeholder = L10n.enterName
        codeTextField.keyboardType = .asciiCapableNumberPad
    }
    private func setupButton(){
        self.continueToConfirmBtnOutlet.setup(title: L10n.continue, fontSize: 12)
    }
}
