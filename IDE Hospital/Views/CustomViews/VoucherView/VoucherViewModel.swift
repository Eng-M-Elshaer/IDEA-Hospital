//
//  VoucherViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/21/20.
//

import Foundation

protocol VoucherViewModelProtocol {
    func booknow()
    func didTapContinue()
}

class VoucherViewModel{
    
    // MARK:- Private Properties
    private var timeStamp: Double!
    private var doctorID: Int!
}

