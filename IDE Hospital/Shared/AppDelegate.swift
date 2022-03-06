//
//  AppDelegate.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // set app language
        LanguageManager.shared().setLanguage(to: .en)
        // set app IQKeyboardManager
        setupIQKeyboardManager()
        return true
    }
}

//MARK:- Private Methods
extension AppDelegate {
    private func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
