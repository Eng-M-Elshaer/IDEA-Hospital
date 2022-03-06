//
//  String+Localization.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Foundation

extension String {
    var localized: String {
        var result: String
        let languageCode = LanguageManager.shared().getCurrentLanguage()
        var path = Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj")
        if path == nil, let hyphenRange = languageCode.rawValue.range(of: "-") {
            let languageCodeShort = String(languageCode.rawValue[..<hyphenRange.lowerBound])//.substring(to: hyphenRange.lowerBound) // en
            path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj")
        }
        if let path = path, let locBundle = Bundle(path: path) {
            result = locBundle.localizedString(forKey: self, value: nil, table: nil)
        } else {
            result = NSLocalizedString(self, comment: "")
        }
        return result
    }
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9",
                   "," : "."]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    public var replaceEnglishDigitsWithArabic: String {
        var str = self
        let map = ["0": "٠",
                   "1": "١",
                   "2": "٢",
                   "3": "٣",
                   "4": "٤" ,
                   "5": "٥",
                   "6": "٦",
                   "7": "٧",
                   "8": "٨",
                   "9": "٩",
                   "." : ","]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}
