//
//  MyAppointmentsView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

class MyAppointmentsView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    // MARK:- Public Methods
    func setup(){
        registerNib()
        self.backgroundColor = .clear
        setupNoResultLabel()
    }
    func showNoResult(){
        noResultLabel.isHidden = false
        tableView.isHidden = true
    }
    func showResult(){
        noResultLabel.isHidden = true
        tableView.isHidden = false
    }
}

//MARK:- Private Mothods
extension MyAppointmentsView{
    private func registerNib(){
        let cell = UINib(nibName: MyAppointmentsTableViewCell.ID, bundle:nil)
        tableView.register(cell, forCellReuseIdentifier: MyAppointmentsTableViewCell.ID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    private func setupNoResultLabel(){
        noResultLabel.textColor = .white
        noResultLabel.font = FontFamily.PTSans.bold.font(size: 15)
        noResultLabel.text = L10n.noAppointmentsFound
        noResultLabel.isHidden = true
    }
}
