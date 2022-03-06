//
//  UIViewController+Alert.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

extension UIViewController {
    func showAlert(type: IDEAlertTypes, title: String, message: String, buttonTitle: String? = L10n.confirm,  completion: (()->Void)? = nil) {
        let alert = IDEAlertViewController.create(type: type)
        alert.type = type
        alert.title = title
        alert.message = message
        alert.completion = completion
        alert.buttonTitle = buttonTitle
        
        alert.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(alert, animated: true, completion: nil)
        
//        self.addChild(alert)
//        alert.didMove(toParent: self)
//        alert.view.frame = view.frame
//        self.view.addSubview(alert.view)
    }
}
