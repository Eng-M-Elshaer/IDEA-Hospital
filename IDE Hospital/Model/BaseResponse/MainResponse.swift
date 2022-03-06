//
//  MainResponse.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import Foundation

// MARK: - Main Response
struct MainResponse<Data: Decodable>: Decodable {
    let success: Bool?
    let code: Int?
    let data: Data?
    let errors: Errors?
    let message: String?
}

// MARK: - DataArray
struct DataArray<items: Codable>: Decodable {
    let items: [items]?
    let total: Int
    let page: Int
    let per_page: Int
    let total_pages: Int
}

// MARK: - SuccessOnly
struct SuccessOnly: Decodable{
}

// MARK: - Responses Typealias
typealias DoctorDetailsResponse = MainResponse<DoctorProfile>
typealias DoctorAppointmentResponse = MainResponse<[AppointmentDate]>
typealias DoctorReviewsResponse = MainResponse<DataArray<Review>>
typealias BookNowResponse = MainResponse<BookingData>
typealias ReviewResponse = MainResponse<Review>
typealias DoctorResultResponse = MainResponse<DataArray<DoctorProfile>>
typealias ServicesResponse = MainResponse<ServicesSearch>
typealias SignReponse = MainResponse<Register>
typealias MainCategoriesResponse = MainResponse<[MainCategories]>
typealias AboutUsResponse = MainResponse<AboutUs>
typealias TermsAndConditionsResponse = MainResponse<TermsAndConditions>
typealias MyAppointmentsResponse = MainResponse<DataArray<MyAppointment>>
//because error comes in array so error in decoding
typealias DeleteAppointmentResponse = MainResponse<SuccessOnly>
typealias ContactUsResponse = MainResponse<SuccessOnly>
typealias NurseResponse = MainResponse<SuccessOnly>
