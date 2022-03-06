//
//  ServicesSearch.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import Foundation

// MARK: - Services Search
struct ServicesSearch: Codable {
    let specialties: [Company]
    let cities: [City]
    let companies: [Company]
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    var regions: [Company]?
}

// MARK: - Company
struct Company: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Doctors Data Query
struct DoctorsQuery {
    var mainID: Int?
    var specialtiesID: Int?
    var cityID: Int?
    var regionID: Int?
    var compayID: Int?
    var doctorName: String?
}
