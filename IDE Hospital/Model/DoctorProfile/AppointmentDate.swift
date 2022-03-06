//
//  Data.swift
//
//  Created by Ibrahim El-geddawy on 10/18/20
//  Copyright (c) . All rights reserved.
//

import Foundation

// MARK: - Appointment Date
struct AppointmentDate: Codable {

    var date: Double?
    var times: [Times]?
    
    enum CodingKeys: String, CodingKey {
      case date, times
    }
}
