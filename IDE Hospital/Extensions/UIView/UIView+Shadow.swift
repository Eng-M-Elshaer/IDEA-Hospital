//
//  UIView+Shadow.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    func cornerStylish(color : UIColor, borderWidth: CGFloat, cornerRadius : CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        clipsToBounds = true
    }
}
