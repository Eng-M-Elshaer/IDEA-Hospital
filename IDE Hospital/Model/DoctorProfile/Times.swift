//
//  Times.swift
//
//  Created by Ibrahim El-geddawy on 10/18/20
//  Copyright (c) . All rights reserved.
//

import Foundation

// MARK: - Times
struct Times: Codable {

    var time: Double?
    var booked: Bool?

    enum CodingKeys: String, CodingKey {
      case time
      case booked
    }
}
