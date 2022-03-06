//
//  Validator.swift
//  IUMAK-iOS
//
//  Created by Mustafa on 23/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

// MARK:- FieldType
enum FieldType {
    
    case name
    case email
    case password
    case confirmPassword
    case oldPassword
    case newPassword
    case mobile
    case phone

    var regex: String {
        switch self {
        case .name:
            // Company name: Accept Letters, numbers and spaces
            return "[\u{0621}-\u{064A}a-zA-Z0-9 ]+"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .password, .newPassword:
            // Password: Should include 1 Capital letter, 1 Number, and min 12 character, Don’t allow special character
            return "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{12,}$"
        case .mobile:
            // Mobile with or without 020. Ex (1008455631, 01008455631, 0201008455631)
            return "^[\\d]{10}$"
        default:
            return ""
        }
    }
}

class Validator {
	
	// MARK:- Singleton
	private static let sharedInstance = Validator()
	
	class func shared() -> Validator {
		return Validator.sharedInstance
	}
	
	// MARK:- Public Methods
	func isValid(entry: String, type: FieldType) -> Bool {
		var entry = entry
		if type == .mobile {
			entry = removePrefix(from: entry)
		}
		return NSPredicate(format: "SELF MATCHES %@", type.regex).evaluate(with: entry)
	}
	func isValid(loginEmailField: String) -> Bool {
		if isValid(entry: loginEmailField, type: .email) || isValid(entry: loginEmailField, type: .mobile) {
			return true
		}
		return false
	}
	func isValid(phone: String) -> Bool {
		if isValid(entry: phone, type: .mobile) {
			return true
		}
		return false
	}
}

// MARK:- Private Methods
extension Validator {
    private func removePrefix(from number: String) -> String {
        // Trim (+, 0, 02, 020) prefixes
        let trimmedLeadingPlus = number.hasPrefix("+") ? "\(number.dropFirst())" : number
        let trimmedLeadingZero = trimmedLeadingPlus.hasPrefix("0") ? "\(trimmedLeadingPlus.dropFirst())" : trimmedLeadingPlus
        let trimmedLeadingTwoZero = trimmedLeadingZero.hasPrefix("20") ? "\(trimmedLeadingZero.dropFirst(2))" : trimmedLeadingZero
        return trimmedLeadingTwoZero
    }
    private func handleLandlineEntry(entry: String) -> String {
        var entry = entry
        // Handling Alex. landline numbers
        if entry.first == Character("3") {
            entry = "0" + entry
        }
        entry = removePrefix(from: entry)
        print(entry)
        return entry
    }
}
