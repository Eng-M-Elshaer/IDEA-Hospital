//
//  APIManager.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import Alamofire

class APIManager {
    
    //MARK:- User
    static func getUserData(completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.getUser) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Auth PopUp
    static func bookWithRegsiter(userData: UserData, completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.bookWithRegister(user: userData)) { (response) in
            completion(response)
        }
    }
    static func bookWithLogin(userData: UserData, completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.bookWithLogin(user: userData)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Favorites
    static func getFavorites(page: Int, completion: @escaping (Result<DoctorResultResponse, Error>) -> ()) {
        request(APIRouter.getFavotites(page)) { response in
            completion(response)
        }
    }
    static func handleFavorite(id: Int, completion: @escaping (Result<MainCategoriesResponse, Error>) -> ()) {
        request(APIRouter.handleFavorite(id)) { response in
            completion(response)
        }
    }
    
    //MARK:- Auth
    static func editProfile(userData: UserData, completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.editProfile(user: userData)) { (response) in
            completion(response)
        }
    }
    static func resetPassword(userData: UserData, completion:@escaping (Result<MainCategoriesResponse, Error>)-> ()){
        request(APIRouter.resetPassword(user: userData)) { (response) in
            completion(response)
        }
    }
    static func login(userData: UserData, completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.login(user: userData)) { (response) in
            completion(response)
        }
    }
    static func setUser(userData: UserData, completion:@escaping (Result<SignReponse, Error>)-> ()){
        request(APIRouter.register(user: userData)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- Doctor Details
    static func doctorDetails(doctorID: Int, completion:@escaping (Result<DoctorDetailsResponse, Error>)-> ()){
        request(APIRouter.doctorDetails(id: doctorID)) { (response) in
            completion(response)
        }
    }
    static func doctorAppointments(doctorID: Int, completion:@escaping (Result<DoctorAppointmentResponse, Error>)-> ()){
        request(APIRouter.doctorAppointments(id: doctorID)) { (response) in
            completion(response)
        }
    }
    static func doctorReviews(doctorID: Int, completion:@escaping (Result<DoctorReviewsResponse, Error>)-> ()){
        request(APIRouter.doctorReviews(id: doctorID)) { (response) in
            completion(response)
        }
    }
    static func postReview(doctorID: Int, comment: String,rating: Int, completion:@escaping (Result<ReviewResponse, Error>)-> ()){
        request(APIRouter.saveUserReview(doctorID, comment, rating)) { (response) in
            completion(response)
        }
    }
    
    //MARK:- My Appointments
    static func getMyAppointments(page: Int, completion: @escaping (Result<MyAppointmentsResponse, Error>)-> ()){
        request(APIRouter.getMyAppointments(page)) { (response) in
            completion(response)
        }
    }
    static func deleteAppointment(id: Int, completion: @escaping (Result<DeleteAppointmentResponse, Error>)->()){
        request(APIRouter.deleteUserAppointment(id)) { (response) in
            completion(response)
        }
    }
    //MARK:- Book Now
    static func bookNow(bookData: BookingData, completion: @escaping (Result<BookNowResponse, Error>)->()){
        request(APIRouter.userBookNow(book: bookData)){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Static Content
    static func getAboutus(completion: @escaping (Result<AboutUsResponse, Error>)->()){
        request(APIRouter.getAboutus){ (response) in
            completion(response)
        }
    }
    static func getTerms(completion: @escaping (Result<TermsAndConditionsResponse, Error>)->()){
        request(APIRouter.getTerms){ (response) in
            completion(response)
        }
    }
    
    //MARK:- Doctors List
    static func getDoctorsList(data: DoctorsQuery, sortBy: String?, page: Int, completion: @escaping (Result<DoctorResultResponse, Error>) -> ()) {
        request(APIRouter.getDoctors(data: data, sortBy: sortBy, page: page)) { response in
            completion(response)
        }
    }
    
    //MARK:- Doctors Query Parameters
    static func getDoctorsQueryParameters(id: Int, completion: @escaping (Result<ServicesResponse, Error>) -> ()) {
        request(APIRouter.getDoctorsQueryParameters(id)) { response in
            completion(response)
        }
    }
    
    //MARK:- Main Categories
    static func getMainCategories(completion: @escaping (Result<MainCategoriesResponse, Error>) -> ()) {
        request(APIRouter.mainCategories) { response in
            completion(response)
        }
    }
    
    //MARK:- Send Request
    static func sendContactUs(requestData: RequestBodyData,completion: @escaping (Result<ContactUsResponse, Error>)-> ()) {
        request(APIRouter.contactus(requestData)) { (response) in
            completion(response)
        }
    }
    static func sendNurseRequest(requestData: RequestBodyData, completion: @escaping (Result<NurseResponse, Error>)-> ()) {
        request(APIRouter.nurseRequest(requestData)) { (response) in
            completion(response)
        }
    }
}

// MARK:- The request function to get results in a closure
extension APIManager {
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
}
