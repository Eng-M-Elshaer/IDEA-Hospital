//
//  BaseClass.swift
//
//  Created by Ibrahim El-geddawy on 10/18/20
//  Copyright (c) . All rights reserved.
//

import Foundation

// MARK: - Review
struct Review: Codable {

    var id: Int?
    var rating: Int?
    var commentedBy: String?
    var comment: String?
    
    enum CodingKeys: String, CodingKey {
      case id, comment, rating
      case commentedBy = "commented_by"
    }
}
