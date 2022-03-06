//
//  BookingData.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import Foundation

// MARK: - Booking Data
struct BookingData: Codable{
    
    var doctorID: Int
    var appointment: Double
    var username: String?
    var bookForAnother: Int = 0
    var voucher: String?
    var patientName: String?
    
    enum CodingKeys: String, CodingKey {
        case appointment, username, voucher
        case doctorID = "doctor_id"
        case bookForAnother = "book_for_another"
        case patientName = "patient_name"
    }
}
