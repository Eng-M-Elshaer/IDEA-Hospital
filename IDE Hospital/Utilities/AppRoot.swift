//
//  AppRoot.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/22/20.
//

import UIKit

/// go to App Root
struct AppRoot {
    static func createRoot(){
        let window: UIWindow? = UIApplication.shared.windows.first
        let mainVC: MainVC = MainVC.create()
        let mainNavigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = mainNavigationController
    }
}
