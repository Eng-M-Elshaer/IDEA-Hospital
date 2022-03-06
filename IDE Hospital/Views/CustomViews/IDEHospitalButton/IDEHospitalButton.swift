//
//  IDEHospitalButton.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

class IDEHospitalButton: UIButton {
    
    // MARK:- Public Methods
    func setup(title: String, fontSize: CGFloat = 20, font: FontConvertible = FontFamily.PTSans.bold) {
        setupRadius()
        setTitle(title, for: .normal)
        setupButtonColors()
        titleLabel?.font = font.font(size: fontSize)
    }
}

// MARK:- Private Methods
extension IDEHospitalButton {
    private func setupRadius() {
        layoutIfNeeded()
        layer.cornerRadius = 10
    }
    private func setupButtonColors() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .darkRoyalBlue
    }
}
