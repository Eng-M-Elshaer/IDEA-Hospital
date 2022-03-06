//
//  UIView+Localization.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

// Localization Association Variables
private var localizeEnabled: Bool = false
private var associatedFontSize: CGFloat = CGFloat.leastNormalMagnitude
private var associatedFontName: String = ""

enum TayarFontType: String {
    case title
    case subtitle
    case text
}

//MARK:- UIView
extension UIView {
    func getFontByType(type: String) -> UIFont {
        var font = UIFont.systemFont(ofSize: 17.0)
        guard let enumValue = TayarFontType(rawValue: type) else {
            return font
        }
        switch enumValue {
        case .title:
            // TODO: to be loaded from constansts class
            font = UIFont.boldSystemFont(ofSize: 26)
        default:
            font = UIFont.systemFont(ofSize: 12)
        }
        return font
    }
    //MARK:- IBInspectable
    @IBInspectable var fontType: String {
        set (value) {
            objc_setAssociatedObject(self, &associatedFontName, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let assoicatedValue = objc_getAssociatedObject(self, &associatedFontName) as? String else {
                return ""
            }
            return assoicatedValue
        }
    }
    @IBInspectable var enableLocalization: Bool {
        set (value) {
            objc_setAssociatedObject(self, &localizeEnabled, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let assoicatedValue = objc_getAssociatedObject(self, &localizeEnabled) as? Bool else {
                return false
            }
            return assoicatedValue
        }
    }
    @IBInspectable var fontSize: CGFloat {
        set (value) {
            objc_setAssociatedObject(self, &associatedFontSize, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let assoicatedValue = objc_getAssociatedObject(self, &associatedFontSize) as? CGFloat else {
                return CGFloat.leastNormalMagnitude
            }
            return assoicatedValue
        }
    }
    func localizeSubViews() {
        self.subviews.forEach { (view) in
            if let lbl = view as? UILabel {
                if lbl.enableLocalization == true {
                    lbl.localize()
                    //                    lbl.adjustFontAttributes()
                }
            } else if let lbl = view as? UIButton {
                if lbl.enableLocalization == true {
                    lbl.localize()
                    //                    lbl.adjustFontAttributes()
                }
            } else if let lbl = view as? UITextField {
                if lbl.enableLocalization == true {
                    lbl.localize()
                    //                    lbl.adjustFontAttributes()
                }
            } else if let lbl = view as? UITextView {
                if lbl.enableLocalization == true {
                    lbl.localize()
                    //                    lbl.adjustFontAttributes()
                }
            } else {
                view.localizeSubViews()
            }
        }
    }
}

//MARK:- UILabel
extension UILabel {
    func localize() {
        // adding localized string
        self.text = self.text ?? ""
        self.text = self.text!.localized
        // TODO: if isRTL
        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.shared().isRTL() {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
    func adjustFontAttributes () {
        self.font = self.getFontByType(type: self.fontType)
        if self.fontSize != CGFloat.leastNormalMagnitude {
            self.font = self.font.withSize(self.fontSize)
        }
    }
}

//MARK:- UITextField
extension UITextField {
    func localize() {
        // check placeholder
        if !self.placeholder.isBlank {
            self.placeholder = placeholder!.localized
        } else {
            self.text = self.text ?? ""
            self.text = self.text!.localized
        }
        // TODO: if isRTL
        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.shared().isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
    func adjustFontAttributes () {
        self.font = self.getFontByType(type: self.fontType)
        if self.fontSize != CGFloat.leastNormalMagnitude {
            self.font = self.font?.withSize(self.fontSize)
        }
    }
}

//MARK:- UITextView
extension UITextView {
    func localize() {
        // check placeholder
        self.text = self.text ?? ""
        self.text = self.text!.localized
        // TODO: if isRTL
        if self.textAlignment == .left || self.textAlignment == .right {
            if LanguageManager.shared().isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
    func adjustFontAttributes () {
        self.font = self.getFontByType(type: self.fontType)
        if self.fontSize != CGFloat.leastNormalMagnitude {
            self.font = self.font?.withSize(self.fontSize)
        }
    }
}

//MARK:- UIButton
extension UIButton {
    func localize() {
        let localizedString = self.titleLabel?.text?.localized ?? ""
        self.setTitle(localizedString, for: .normal)
        // TODO: if isRTL
        if self.contentHorizontalAlignment == .right || self.contentHorizontalAlignment == .left {
            if LanguageManager.shared().isRTL()  {
                self.contentHorizontalAlignment = .right
            } else {
                self.contentHorizontalAlignment = .left
            }
        }
        
    }
    func adjustFontAttributes () {
        self.titleLabel?.font = self.getFontByType(type: self.fontType)
        if self.fontSize != CGFloat.leastNormalMagnitude {
            self.titleLabel?.font = self.titleLabel?.font.withSize(self.fontSize)
        }
    }
}
