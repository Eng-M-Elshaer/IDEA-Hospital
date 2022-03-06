//
//  BaseClass.swift
//
//  Created by Ibrahim El-geddawy on 10/19/20
//  Copyright (c) . All rights reserved.
//

import Foundation

// MARK: - MyAppointment
struct MyAppointment: Codable {
    
    var doctor: DoctorProfile?
    var bookForAnother: Bool?
    var id: Int?
    var patientName: String?
    var appointment: Double?
    
    enum CodingKeys: String, CodingKey {
        case doctor, id, appointment
        case bookForAnother = "book_for_another"
        case patientName = "patient_name"
    }
}
