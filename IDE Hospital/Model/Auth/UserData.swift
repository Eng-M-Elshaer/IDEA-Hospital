//
//  UserData.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/19/20.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    
    var name: String?
    var email: String
    var mobile: String?
    var password: String?
    var oldPassword: String?
    var doctorID: Int?
    var appointment: String?
    var patientName: String?
    var voucher: String?
    var isbookForAnother: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, email, mobile, password, appointment, voucher
        case oldPassword = "old_password"
        case doctorID = "doctor_id"
        case patientName = "patient_name"
        case isbookForAnother = "book_for_another"
    }
}
