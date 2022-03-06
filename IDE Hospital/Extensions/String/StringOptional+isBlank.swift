//
//  StringOptional+isBlank.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Foundation

extension Optional where Wrapped == String {
    var isBlank: Bool {
        return self == nil || self!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

