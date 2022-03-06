//
//  MyAppointmentsViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/20/20.
//

import Foundation

protocol MyAppointmentsViewModelProtocol {
    func getMyAppointments()
    func getMyAppointmentsCount()-> Int
    func getAppointment(at index: Int) -> MyAppointment
    func getNextPaginationPage()
    func deleteAppointment(at index: Int)
    func viewDoctorLocation(at index: Int)
    func didTapBack()
    func deleteAppointment()
    func setupTabBar()
}

class MyAppointmentViewModel{
    
    // MARK:- Private Properties
    private weak var view: MyAppointmentVCProtocol?
    private var paginationPageNumber: Int!
    private var lastPaginationPage: Int!
    private var appointments: [MyAppointment]?
    private var comeFrom: ComeFrom!
    private var id: Int!
    
    // MARK:- Init
    init(view: MyAppointmentVCProtocol,ComFrom: ComeFrom){
        self.view = view
        self.comeFrom = ComFrom
    }
}

//MARK:- Conform Protocol
extension MyAppointmentViewModel: MyAppointmentsViewModelProtocol{
    func getMyAppointments() {
        paginationPageNumber = 1
        appointments = nil
        if UserDefaultsManager.shared().isLoggedIn {
            requestAppointments()
        } else {
            self.view?.showResult(state: .notFound)
        }
    }
    func getMyAppointmentsCount()-> Int {
        return appointments?.count ?? 0
    }
    func getAppointment(at index: Int) -> MyAppointment {
        return appointments?[index] ?? MyAppointment()
    }
    func getNextPaginationPage() {
        if paginationPageNumber < lastPaginationPage {
            paginationPageNumber += 1
            requestAppointments()
        }
    }
    func deleteAppointment(at index: Int) {
        if let timeStamp = self.appointments?[index].appointment, let id = self.appointments?[index].id {
            self.id = id
            if timeStamp < Date().timeIntervalSince1970 - (24*3600) {
                requestDeleteAppointment(id: id)
            }else if timeStamp > Date().timeIntervalSince1970 + (24*3600){
                self.view?.confirmDeleteAppointment()
                
            } else {
                self.view?.showError(with: L10n.cancelAppointmentError)
            }
        }
    }
    func deleteAppointment() {
        requestDeleteAppointment(id: self.id)
    }
    func viewDoctorLocation(at index: Int) {
        if let lat = self.appointments?[index].doctor?.lat, let long = self.appointments?[index].doctor?.lng{
            self.view?.openGoogleMap(lat: lat, lng: long)
        }
    }
    func didTapBack() {
        switch comeFrom {
        case .settings:
            self.view?.goBack()
        default:
            self.view?.goToRoot()
        }
    }
    func setupTabBar(){
        switch comeFrom {
        case .settings:
            self.view?.tabBarController?.tabBar.isHidden = true
        default:
            self.view?.tabBarController?.tabBar.isHidden = false
            self.view?.addSettingsButton()
        }
    }
}

//MARK:- APIs
extension MyAppointmentViewModel{
    private func requestAppointments(){
        view?.showLoader()
        APIManager.getMyAppointments( page: paginationPageNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                switch response.code {
                case 200:
                    if let appointments = response.data?.items, !appointments.isEmpty {
                        if self.appointments != nil {
                            self.appointments? += appointments
                        } else {
                            self.appointments = appointments
                        }
                        self.lastPaginationPage = response.data?.total_pages
                        self.view?.showResult(state: .found)
                        self.view?.reloadTableView()
                    } else {
                        self.view?.showResult(state: .notFound)
                    }
                default:
                    if let errorMessages = response.errors?.formattedErrors() {
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
    private func requestDeleteAppointment(id: Int){
        self.view?.showLoader()
        APIManager.deleteAppointment(id: id) { [weak self] (result) in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                switch response.code {
                case 202:
                    self.view?.showSuccess(with: L10n.appointmentDeletedSuccessfully)
                default:
                    if let errorMessages = response.message {
                        self.view?.showError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.showError(with: error.localizedDescription)
            }
            self.view?.hideLoader()
        }
    }
}
