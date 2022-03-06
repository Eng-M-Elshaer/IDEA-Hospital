//
//  UIViewController+showRegPopUp.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/20/20.
//

import UIKit

extension UIViewController {
    func showRegPopup(timeStamp: String, doctorID: Int) {
        let popup = RegisterPopUpVC()
        popup.timestamp = timeStamp
        popup.doctorID = doctorID
        self.addChild(popup)
        popup.didMove(toParent: self)
        popup.view.frame = view.frame
        popup.registerPopUpView.layoutIfNeeded()
        self.view.addSubview(popup.view)
    }
}
