//
//  RequestBody.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/21/20.
//

import Foundation

// MARK: - RequestBodyData
struct RequestBodyData: Codable{
    
    let name: String?
    let mobile: String?
    let email: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case name, mobile, email, message
    }
}
