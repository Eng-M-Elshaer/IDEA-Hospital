//
//  DrProfileViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import Foundation

enum LoaderType{
    case profile
    case appointments
    case review
}

protocol DrProfileviewModelProtocol {
    func getReview()
    func getAppointment() -> AppointmentDate
    func getAppointmentTimes(at index: Int) -> Times
    func appoinmentTimesCount()->Int
    func reviewsCount()->Int
    func getReviews(at index: Int) -> Review
    func getDrProfileData()
    func getDrAppointmentsData()
    //Actions
    func didTapBook()
    func didTapViewOnMap()
    func didTapReview()
    func didTapFavourite()
    func didTapAppointmentTime(at index: Int)
    func didTapNext()
    func didTapPrevious()
    func booknow()
    func getVoucher(voucher: String, patientName: String)
}

class DrProfileViewModel{
    
    // MARK:- Private Properties
    weak private var view: DrProfileViewControllerProtocol?
    private var id: Int!
    private var doctorProfile: DoctorProfile!
    private var appointmentsDate: [AppointmentDate]?
    private var reviews: [Review]?
    private var voucher: String = ""
    private var patientName :String = ""
    private var appointmentTimeStamp: Double = 0
    private var appointmentIndex = 0{
        didSet{
            self.view?.reloadAppointmentsCollectionView()
            let appointment = self.getAppointment()
            self.view?.setupAppoinmentDate(appointment: appointment)
            self.appointmentTimeStamp = 0
            let times = self.getAppoinmentTime()
            if times.count > 0 {
                self.view?.showResult(state: .found)
            }else{
                self.view?.showResult(state: .notFound)
            }
        }
    }
    
    // MARK:- Init
    init(view: DrProfileViewControllerProtocol, id: Int) {
        self.view = view
        self.id = id
    }
    
}

//MARK:- Conform Protocol
extension DrProfileViewModel: DrProfileviewModelProtocol{
    func didTapViewOnMap() {
        if let lat = self.doctorProfile.lat, let lng = self.doctorProfile.lng{
            self.view?.openMap(lat: lat, lng: lng)
        }
    }
    func getAppointment() -> AppointmentDate {
        if self.appointmentsDate != nil{
            return self.appointmentsDate![appointmentIndex]
        }
        return AppointmentDate()
    }
    func appoinmentTimesCount() -> Int {
        if let appointment = self.appointmentsDate?[appointmentIndex]{
            return appointment.times?.count ?? 0
        }
        return 0
    }
    func reviewsCount() -> Int {
        if let reviewsCount = self.reviews?.count{
            return reviewsCount
        }
        return 0
    }
    func getReviews(at index: Int) -> Review {
        if let reviews = self.reviews{
            return reviews[index]
        }
        return Review()
    }
    func getAppointmentTimes(at index: Int) -> Times {
        let times = self.getAppoinmentTime()
        if index >= 0 && index < times.count{
            return times[index]
        }
        return Times()
    }
    func getDrProfileData() {
        self.getDoctorProfileData()
    }
    func getDrAppointmentsData() {
        getDoctorAppointmentsData()
    }
    func getReview() {
        self.getDoctorReview()
    }
    //MARK:- Actions
    func didTapFavourite() {
        if UserDefaultsManager.shared().isLoggedIn{
            self.favourite()
        }else{
            self.view?.showError(with: L10n.sorryYouShouldLoginFirst)
        }
    }
    func didTapReview(){
        self.view?.goToReviewVC(id: self.id)
    }
    func didTapBook() {
        self.bookingValidation()
    }
    func didTapAppointmentTime(at index: Int) {
        if let selectecTime = self.getAppointmentTimes(at: index).time{
            self.appointmentTimeStamp = selectecTime
        }
    }
    func didTapPrevious() {
        if appointmentIndex > 0 {
            self.appointmentIndex -= 1
        }
    }
    func didTapNext() {
        if let appointments = self.appointmentsDate{
            if appointmentIndex < appointments.count - 1{
                appointmentIndex += 1
            }
        }
    }
    func getVoucher(voucher: String, patientName: String) {
        self.voucher = voucher
        self.patientName = patientName
        self.view?.showConfirm(with: "You are about to book an appointment \(AppUtility.formattedDate(self.appointmentTimeStamp)) with \(String(describing: self.doctorProfile.name  ?? ""))")
    }
    func booknow() {
        let book = self.getBookingData()
        self.BookNow(bookData: book)
    }
}

//MARK:- private methods logic
extension DrProfileViewModel{
    private func getAppoinmentTime()-> [Times]{
        if let appointment = self.appointmentsDate?[appointmentIndex]{
            return appointment.times ?? [Times]()
        }
        return [Times]()
    }
}

//MARK:- Validations
extension DrProfileViewModel{
    private func bookingValidation(){
        if appointmentTimeStamp != 0 && UserDefaultsManager.shared().isLoggedIn{
            self.view?.showVoucher()
        }else if appointmentTimeStamp == 0{
            self.view?.showError(with: L10n.chooseAppointmentError)
        }else if !UserDefaultsManager.shared().isLoggedIn && appointmentTimeStamp != 0{
            self.view?.showSignin(timeStamp: String(describing: appointmentTimeStamp), doctorID: self.id)
        }
    }
    private func getBookingData()->BookingData{
        if patientName.isEmpty && self.voucher.isEmpty{
            return BookingData(doctorID:  self.id, appointment: appointmentTimeStamp)
        }else if patientName.isEmpty && !voucher.isEmpty{
            return BookingData(doctorID: self.id, appointment: appointmentTimeStamp, voucher: self.voucher)
        }else if self.voucher.isEmpty && !patientName.isEmpty{
            return BookingData(doctorID: self.id, appointment: appointmentTimeStamp, bookForAnother: 1, patientName: patientName)
        }
        return BookingData(doctorID: self.id, appointment: appointmentTimeStamp, bookForAnother: 1, voucher: self.voucher, patientName: self.patientName)
    }
}
//MARK:- APIs
extension DrProfileViewModel{
    //MARK:- API Call
    private func getDoctorProfileData() {
        self.view?.showLoader(type: .profile)
        APIManager.doctorDetails(doctorID: self.id){
            [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 200:
                    if let data = response.data{
                        self.doctorProfile = data
                        self.view?.setupDrProfile(profile: data)
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
        }
        self.view?.hideLoader(type: .profile)
    }
    private func getDoctorAppointmentsData() {
        self.view?.showLoader(type: .appointments)
        APIManager.doctorAppointments(doctorID: self.id) {
            [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 200:
                    if let data = response.data{
                        self.appointmentsDate = data
                        self.view?.reloadAppointmentsCollectionView()
                        self.view?.setupAppoinmentDate(appointment: self.getAppointment())
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
        }
        self.view?.hideLoader(type: .appointments)
    }
    private func getDoctorReview() {
        self.view?.showLoader(type: .review)
        APIManager.doctorReviews(doctorID: self.id) {
            [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 200:
                    if let data = response.data?.items{
                        self.reviews = data
                        self.view?.reloadReviewTableView()
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader(type: .review)
        }
    }
    private func BookNow(bookData: BookingData){
        self.view?.showLoader(type: .profile)
        APIManager.bookNow(bookData: bookData) {
            [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 202:
                    self.view?.showSuccess(with: L10n.appointmentSuccessfullyBooked)
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader(type: .profile)
        }
    }
    private func favourite(){
        self.view?.showLoader(type: .profile)
        APIManager.handleFavorite(id: self.id) { (result) in
            switch result{
            case .success(let response):
                switch response.code {
                case 202:
                    self.doctorProfile.isFavorited = !(self.doctorProfile.isFavorited ?? false)
                    self.view?.setupDrProfile(profile: self.doctorProfile)
                default:
                    self.view?.showError(with: L10n.sorry)
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader(type: .profile)
        }
    }
}
