//
//  LanguageManager.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//  Created by IDEAcademy on 6/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

enum Language: String {
    case ar = "ar"
    case en = "en"
}

class LanguageManager {
    
    // MARK:- Singleton
    private static let sharedInstance = LanguageManager()
    
    class func shared() -> LanguageManager {
        return LanguageManager.sharedInstance
    }
    
    private init() {
        // set default language
        let currentLocale = getCurrentLanguage()
        setLanguage(to: currentLocale)
    }
    
    // MARK:- Public Methods
    func setLanguage(to newLang: Language) {
        switch newLang {
        case .ar:
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        default:
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        UserDefaults.standard.set(newLang.rawValue, forKey: LocalizationKeys.appLocale)
        UserDefaults.standard.set([newLang.rawValue], forKey: LocalizationKeys.appleLanguages)
        UserDefaults.standard.synchronize()
    }
    func getCurrentLanguage() -> Language {
        guard let locale = UserDefaults.standard.string(forKey: LocalizationKeys.appLocale) else {
            return .en
        }
        return Language(rawValue: locale) ?? .en
    }
    func getDescription(of lang: Language) -> String {
        switch lang {
        case .en:
            return "English"
        default:
            return "العربية"
        }
    }
    func isRTL() -> Bool {
        guard let locale = UserDefaults.standard.string(forKey: LocalizationKeys.appLocale) else {
            return true
        }
        return locale == "ar"
    }
}
