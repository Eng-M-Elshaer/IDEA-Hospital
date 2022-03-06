//
//  String+trimmed.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
