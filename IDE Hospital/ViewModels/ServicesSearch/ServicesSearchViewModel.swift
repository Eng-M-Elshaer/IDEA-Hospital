//
//  ServicesSearchViewModel.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

protocol ServicesSearchViewModelProtocol {
    func numberOfRows(for textField: UITextField) -> Int
    func title(for textField: UITextField, row: Int) -> String?
    func getDoctorsQueryParameters()
    func getDataQuery() -> DoctorsQuery
}

class ServicesSearchViewModel {
    
    // MARK:- Private Properties
    private weak var view: ServicesSearchVCProtocol?
    private var specialties: [Company] = [Company(id: nil, name: "All")]
    private var cities: [City] = [City(id: nil, name: "All", regions: nil)]
    private var companies: [Company] = [Company(id: nil, name: "All")]
    private let mainCategoteID: Int!
    private var dataQuery = DoctorsQuery()
    private var cityIndex = 0

    // MARK:- Init
    init(view: ServicesSearchVCProtocol, mainCategoteID: Int) {
        self.mainCategoteID = mainCategoteID
        self.view = view
    }
}

//MARK:- Conform Protocol
extension ServicesSearchViewModel: ServicesSearchViewModelProtocol {
    func getDataQuery() -> DoctorsQuery {
        return DoctorsQuery(mainID: mainCategoteID, specialtiesID: dataQuery.specialtiesID, cityID: dataQuery.cityID, regionID: dataQuery.regionID, compayID: dataQuery.compayID, doctorName: "")
    }
    func numberOfRows(for textField: UITextField) -> Int {
        if textField.tag == 0 {
            return specialties.count
        } else if textField.tag == 1 {
            return cities.count
        } else if textField.tag == 2 {
            return cities[cityIndex].regions?.count ?? 0
        } else {
            return companies.count
        }
    }
    
    func title(for textField: UITextField, row: Int) -> String? {
        if textField.tag == 0 {
            dataQuery.specialtiesID = specialties[row].id
            return specialties[row].name
        } else if textField.tag == 1 {
            dataQuery.cityID = cities[row].id
            self.cityIndex = row
            return cities[row].name
        } else if textField.tag == 2 {
            dataQuery.regionID = cities[cityIndex].regions?[row].id
            return cities[cityIndex].regions?[row].name
        } else {
            dataQuery.compayID = companies[row].id
            return companies[row].name
        }
    }
    func getDoctorsQueryParameters(){
        APIManager.getDoctorsQueryParameters(id: mainCategoteID) { (response) in
            switch response {
            case .success(let result):
                if result.code == 200 {
                    guard let data = result.data else {return}
                    self.specialties.append(contentsOf: data.specialties)
                    self.cities.append(contentsOf: data.cities)
                    self.addAllToRegions()
                    self.companies.append(contentsOf: data.companies)
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
    }
}

//MARK:- Private Methods
extension ServicesSearchViewModel {
    private func addAllToRegions(){
        for city in cities {
            cities[city.id ?? 0].regions?.insert(Company(id: nil, name: "All"), at: 0)
        }
    }
}
