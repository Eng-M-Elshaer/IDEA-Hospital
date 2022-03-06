//
//  APIRouter.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // MARK:- The endpoint name
    // Auth
    case login(user: UserData)
    case register(user: UserData)
    case resetPassword(user: UserData)
    case editProfile(user: UserData)
    // Doctor
    case getDoctors(data: DoctorsQuery, sortBy: String?, page: Int)
    case doctorDetails(id: Int)
    case doctorAppointments(id: Int)
    case doctorReviews(id: Int)
    // Review
    case saveUserReview(_ id: Int, _ review: String, _ rating: Int)
    // Booking
    case userBookNow(book: BookingData)
    case bookWithLogin(user: UserData)
    case bookWithRegister(user: UserData)
    // Main
    case mainCategories
    case getDoctorsQueryParameters(_ id: Int)
    // Favorite
    case handleFavorite(_ id: Int)
    case getFavotites(_ pageNumber: Int)
    // Static Contents
    case getAboutus
    case getTerms
    // Appointments
    case getMyAppointments(_ pageNumber: Int)
    case deleteUserAppointment(_ id: Int)
    // Send Request
    case contactus(_ requestData: RequestBodyData)
    case nurseRequest(_ requestBody: RequestBodyData)
    // User
    case getUser

    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .mainCategories, .getDoctorsQueryParameters, .getDoctors,.doctorDetails,.doctorReviews, .doctorAppointments, .getAboutus, .getTerms, .getMyAppointments, .getFavotites, .getUser:
            return .get
        case .deleteUserAppointment:
            return .delete
        case .editProfile:
            return .patch
        default:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .doctorDetails(let id):
            return URLs.doctors + "/\(id)"
        case .doctorReviews(let id), .saveUserReview(let id, _, _):
            return URLs.doctors + "/\(id)" + URLs.reviews
        case .doctorAppointments(let id):
            return URLs.doctors + "/\(id)" + URLs.appointments
        case .userBookNow, .getMyAppointments:
            return URLs.userAppointment
        case .mainCategories:
            return URLs.mainCategories
        case .handleFavorite(let id):
            return URLs.favorites + "/\(id)" + URLs.addRemove
        case .getDoctorsQueryParameters(let id):
            return URLs.mainCategories + "/" + "\(id)" + URLs.doctorsQueryParameters
        case .getDoctors(let data,_,_):
            return URLs.mainCategories + "/" + "\(data.mainID ?? 1)" + URLs.doctors
        case .register:
            return URLs.register
        case .resetPassword:
            return URLs.resetPassword
        case .editProfile:
            return URLs.user
        case .getFavotites:
            return URLs.favorites
        case .getAboutus:
            return URLs.aboutus
        case .getTerms:
            return URLs.terms
        case .deleteUserAppointment(let id):
            return URLs.userAppointment + "/\(id)"
        case .bookWithLogin:
            return URLs.userAppointment + URLs.userAppointmentWithLogin
        case .bookWithRegister:
            return URLs.userAppointment + URLs.userAppointmentWithRegister
        case .contactus:
            return URLs.contactus
        case .nurseRequest:
            return URLs.requestNurse
        case .getUser:
            return URLs.user
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .handleFavorite(let id),.doctorDetails(let id), .doctorReviews(let id), .doctorAppointments(let id):
            return [ParameterKey.doctorID: id]
        case .saveUserReview(let id, let comment, let rating):
            return [ParameterKey.doctorID: id, ParameterKey.comment: comment, ParameterKey.rating: rating]
        case .getDoctors(let data, let sortBy, let page):
            return [ParameterKey.specialtyID: data.specialtiesID ?? "",
                    ParameterKey.cityID: data.cityID ?? "",
                    ParameterKey.regionID: data.regionID ?? "",
                    ParameterKey.companyID: data.compayID ?? "",
                    ParameterKey.orderBy: sortBy ?? "fees",
                    ParameterKey.paginationPageNumber: page,
                    ParameterKey.name: data.doctorName ?? "" ]
        case .getMyAppointments(let page):
            return [ParameterKey.paginationPageNumber: page]
        case .getFavotites(let page):
            return [ParameterKey.paginationPageNumber: page]
        case .deleteUserAppointment(let id):
            return [ParameterKey.userAppointmentID: id]
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        switch self {
        case .userBookNow, .saveUserReview, .getMyAppointments, .getUser, .editProfile, .handleFavorite, .getFavotites, .getDoctors, .doctorDetails, .deleteUserAppointment:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        urlRequest.setValue(LanguageManager.shared().getCurrentLanguage().rawValue,
                            forHTTPHeaderField: HeaderKeys.localization)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.accept)
        print(urlRequest.allHTTPHeaderFields ?? "")
        
        // MARK:- HTTP Body
        let httpBody: Data? = {
            switch self {
            case .userBookNow(let body):
                return encodeToJSON(body)
            case .register(let body):
                return encodeToJSON(body)
            case .login(let body):
                return encodeToJSON(body)
            case .resetPassword(let body):
                return encodeToJSON(body)
            case .bookWithLogin(let body):
                return encodeToJSON(body)
            case .bookWithRegister(let body):
                return encodeToJSON(body)
            case .contactus(let body), .nurseRequest(let body):
                return encodeToJSON(body)
            case .editProfile(user: let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
}

//MARK:- encodeToJSON
extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
