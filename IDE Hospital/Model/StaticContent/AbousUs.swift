//
//  AbousUs.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import Foundation

// MARK:- About Us
struct AboutUs: Codable{
    
    var aboutUs: String?
    
    enum CodingKeys: String, CodingKey {
      case aboutUs = "about_us"
    }
}

// MARK:- Terms And Conditions
struct TermsAndConditions: Codable{
    
    var termsAndConditions: String?
    
    enum CodingKeys: String, CodingKey {
      case termsAndConditions = "terms_and_conditions"
    }
}
