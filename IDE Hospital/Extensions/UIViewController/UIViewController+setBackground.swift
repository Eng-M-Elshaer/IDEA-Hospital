//
//  UIViewController+setBackground.swift
//  IDE Hospital
//
//  Created by Elshaer on 1/6/21.
//

import UIKit

extension UIViewController {
    func setBackgroundImage(){
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.backgroundImage.image
        self.view.insertSubview(backgroundImageView, at: 0)
    }
}
