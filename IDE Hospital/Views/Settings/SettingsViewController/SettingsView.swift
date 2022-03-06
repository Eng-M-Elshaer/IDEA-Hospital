//
//  SettingsView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

class SettingsView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var settingsTableView: UITableView!

}

// MARK:- Public Methods
extension SettingsView {
    func setup() {
        setupUI()
        setupTableView()
    }
}

// MARK:- Private Methods
extension SettingsView {
    private func setupUI() {
        self.backgroundColor = .init(white: 255/255, alpha: 0.74)
    }
    private func setupTableView() {
        settingsTableView.backgroundColor = .clear
        settingsTableView.separatorStyle = .none
    }
}
