//
//  UIViewController+Instantiation.swift
//  IUMAK-iOS
//
//  Created by IDEAcademy on 6/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

extension UIViewController {
    class func create<T: UIViewController>(storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
