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

}
class MyAppointmentViewModel{
    private weak var view: MyAppointmentVCProtocol?
    private var paginationPageNumber: Int!
    private var lastPaginationPage: Int!
    private var appointments: [MyAppointment]?

    init(view: MyAppointmentVCProtocol){
        self.view = view
    }
}

extension MyAppointmentViewModel: MyAppointmentsViewModelProtocol{
    func getMyAppointments() {
            paginationPageNumber = 1
            appointments = nil
            requestAppointments()
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
}
extension MyAppointmentViewModel{
    private func requestAppointments(){
        view?.showLoader()
        APIManager.getMyAppointments( page: paginationPageNumber) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                switch response.code {
                case 201:
                    if let appointments = response.data?.items, !appointments.isEmpty {
                     if self.appointments != nil {
                         self.appointments? += appointments
                     } else {
                         self.appointments = appointments
                     }
                     self.lastPaginationPage = response.data?.total_pages
                     self.view?.reloadTableView()
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
}
