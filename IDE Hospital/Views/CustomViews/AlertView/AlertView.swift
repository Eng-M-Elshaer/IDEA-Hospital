//
//  AlertView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

class AlertView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var confirmBtn: IDEHospitalButton!
    @IBOutlet weak var cancelBtn: IDEHospitalButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var closeButtonHieghtConstrain: NSLayoutConstraint!
    @IBOutlet weak var alertImageView: UIImageView!
}

// MARK:- Public Methods
extension AlertView {
    func setup(type: IDEAlertTypes, title: String, message: String, buttonTitle: String = L10n.confirm) {
        setupButtons(buttonTitle: buttonTitle)
        setupType(type: type)
        setupTitleLabel(title: title)
        setupMessageLabel(message: message)
        setupContainerView()
    }
}

// MARK:- Private Methods
extension AlertView {
    private func setupType(type: IDEAlertTypes) {
        switch type {
        case .confirmButton:
            buttonsStackView.alignment = .center
            buttonsStackView.axis = .vertical
            cancelBtn.isHidden = true
            alertImageView.isHidden = true
        case .successButton:
            buttonsStackView.alignment = .center
            buttonsStackView.axis = .vertical
            self.closeBtn.isHidden = true
            alertImageView.isHidden = false
            cancelBtn.isHidden = true
            closeButtonHieghtConstrain.constant = -10
            confirmBtn.setup(title: L10n.ok, fontSize: 16)
               confirmBtn.backgroundColor = .darkRoyalBlue
            alertImageView.image = Asset.ok.image
        case .failButton:
            buttonsStackView.alignment = .center
            buttonsStackView.axis = .vertical
            self.closeBtn.isHidden = true
            alertImageView.isHidden = false
            confirmBtn.isHidden = true
            closeButtonHieghtConstrain.constant = -10
            cancelBtn.setup(title: L10n.ok, fontSize: 16)
               cancelBtn.backgroundColor = .darkRoyalBlue
            alertImageView.image = Asset.fail.image
        case .twoButtons:
            self.messageLabel.isHidden = false
            closeButtonHieghtConstrain.constant = 14
            alertImageView.isHidden = true
            self.closeBtn.isHidden = true
            cancelBtn.setup(title: L10n.no, fontSize: 16)
            cancelBtn.backgroundColor = .purple
        }
    }
    private func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.addShadow()
    }
    private func setupTitleLabel(title: String) {
        titleLabel.text = title
        titleLabel.font = FontFamily.PTSans.bold.font(size: 15)
        titleLabel.textColor = .darkRoyalBlue
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        
    }
    private func setupMessageLabel(message: String) {
        messageLabel.text = message
        messageLabel.font = FontFamily.PTSans.regular.font(size: 15)
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
    }
    private func setupButtons(buttonTitle: String) {
        confirmBtn.setup(title: buttonTitle, fontSize: 16)
//        cancelButton.setup(title: L10n.no, fontSize: 16)
//        cancelButton.backgroundColor = .purple
    }
}
