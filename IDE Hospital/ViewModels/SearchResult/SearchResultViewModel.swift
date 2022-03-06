//
//  SearchResultViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

protocol SearchResultViewModelProtocol {
    func getDoctorResultData(for item: Int) -> DoctorProfile
    func updatetDoctorFavorite(id: Int)
    func setSortBy(_ type: String)
    func getDoctorListCount() -> Int
    func getNextPaginationPage()
    func getResultData()
}

class SearchResultViewModel {
    
    // MARK:- Private Properties
    private weak var view: SearchResultVCProtocol?
    private var doctorResult = [DoctorProfile]()
    private let queryData: DoctorsQuery!
    private var sortBy: String = "fees"
    private var paginationPageNumber: Int!
    private var lastPaginationPage: Int!

    // MARK:- Init
    init(view: SearchResultVCProtocol, queryData: DoctorsQuery) {
        self.queryData = queryData
        self.view = view
    }
}

//MARK:- Conform Protocol
extension SearchResultViewModel: SearchResultViewModelProtocol {
    func getNextPaginationPage() {
        if paginationPageNumber < lastPaginationPage {
            paginationPageNumber += 1
            getListData()
        }
    }
    func setSortBy(_ type: String) {
        self.sortBy = type
        doctorResult.removeAll()
        getListData()
    }
    func updatetDoctorFavorite(id: Int) {
        let filteredProdcutIndex = self.doctorResult.enumerated().filter({ $0.element.id == id}).map({ $0.offset })
        let check = doctorResult[filteredProdcutIndex.first!].isFavorited == true ? false : true
        doctorResult[filteredProdcutIndex.first!].isFavorited = check
        self.view?.updateTableView()
    }
    func getDoctorResultData(for item: Int) -> DoctorProfile {
        return doctorResult[item]
    }
    func getDoctorListCount() -> Int {
        return doctorResult.count
    }
    func getResultData(){
        paginationPageNumber = 1
        doctorResult.removeAll()
        getListData()
    }
}

// MARK:- Call API
extension SearchResultViewModel {
    private func getListData(){
        self.view?.showLoader()
        APIManager.getDoctorsList(data: queryData, sortBy: sortBy, page: paginationPageNumber ) { (response) in
            switch response {
            case .success(let result):
                if result.code == 200 {
                    guard let data = result.data?.items else {return}
                    self.doctorResult += data
                    self.lastPaginationPage = result.data?.total_pages
                    self.view?.updateTableView()
                    self.view?.showResult(state: .found)
                    if data.count == 0 {
                        self.view?.showResult(state: .notFound)
                    }
                } else {
                    if let errorMessages = result.errors?.formattedErrors() {
                        self.view?.showAlert(message: errorMessages)
                    } else {
                        self.view?.showAlert(message: result.message ?? "N/A")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.view?.hideLoader()
    }
}
