//
//  UserDefaultsManager.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Foundation

class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var isLoggedIn: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLoggedIn)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.isLoggedIn) != nil else {
                return false
            }
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)!
        }
    }
}
