//
//  UItextField+Palceholder.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

extension UITextField {
    func setupPlaceholder(text: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.regular.font(size: 20),
            .foregroundColor: UIColor.white.withAlphaComponent(0.6)
        ]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
    }
}
