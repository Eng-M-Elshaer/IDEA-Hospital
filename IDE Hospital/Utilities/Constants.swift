//
//  Constants.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Foundation

//MARK:- Storyboards
struct Storyboards {
    static let main = "Main"
    static let drProfile = "DrProfile"
    static let auth = "Auth"
    static let favorite = "Favorite"
    static let settings = "Settings"
}

//MARK:- UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let isLoggedIn = "UDKIsLoggedIn"
}

//MARK:- LocalizationKeys
struct LocalizationKeys {
    static let appLocale = "Locale"
    static let appleLanguages = "AppleLanguages"
}

//MARK:- Urls
struct URLs {
    static let base = "http://ide-hospital.ideaeg.co/api"
    //auth
    static let login = "/login"
    static let logout = "/logout"
    static let register = "/register"
    static let resetPassword = "/forget_password"
    static let user = "/user"
    //static content
    static let aboutus = "/about_us"
    static let terms = "/terms_and_conditions"
    //dr profile
    static let appointments = "/appointments"
    static let reviews = "/reviews"
    static let userAppointment = "/user_appointments"
    static let userAppointmentWithLogin = "/with_login"
    static let userAppointmentWithRegister = "/with_register"
    // main
    static let mainCategories = "/main_categories"
    // Fav
    static let favorites = "/favorites/doctors"
    static let addRemove = "/add_remove"
    static let doctors = "/doctors"
    static let doctorsQueryParameters = "/doctors_query_parameters"
    static let contactus = "/contact_us_requests"
    static let requestNurse = "/nursing_requests"
}

//MARK:- Parameters Keys
struct ParameterKey {
    static let username = "username"
    static let password = "password"
    static let doctor_id = "doctor_id"
    static let doctorID = "doctor_id"
    static let specialtyID = "specialty_id"
    static let cityID = "city_id"
    static let regionID = "region_id"
    static let companyID = "company_id"
    static let name = "name"
    static let orderBy = "order_by"
    static let comment = "comment"
    static let rating = "rating"
    static let paginationPageNumber = "page"
    static let userAppointmentID = "user_appointment_id"
    static let latitude = "latitude"
    static let longitude = "longitude"
}

//MARK:- Header Keys
struct HeaderKeys {
    static let localization = "Accept-Language"
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let authorization = "Authorization"
}

//MARK:- Custom Cells
struct CustomCells {
    static let mainCell = "MainCell"
    static let searchResultCell = "SearchResultCell"
    static let favoriteCell = "FavoriteCell"
}
