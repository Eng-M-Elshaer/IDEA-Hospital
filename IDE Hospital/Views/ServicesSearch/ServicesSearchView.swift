//
//  ServicesSearchView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

class ServicesSearchView: UIView {
  
    // MARK:- Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var specialistsView: UIView!
    @IBOutlet weak var specialistsTextField: UITextField!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var companiesView: UIView!
    @IBOutlet weak var companiesTextField: UITextField!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var doctorTextField: UITextField!
    @IBOutlet weak var findDoctorBtnOutlet: IDEHospitalButton!
    
    // MARK:- Public Methods
    func setup(){
        setupLabel(label: titleLabel, text: L10n.ideaegHospital, fontType: .bold)
        setupLabel(label: subTitleLabel, text: L10n.theBestChoice, fontType: .regular)
        setupView(view: specialistsView)
        setupView(view: cityView)
        setupView(view: regionView)
        setupView(view: companiesView)
        setupView(view: doctorView)
        findDoctorBtnOutlet.setup(title: L10n.findADoctor)
        setupTextField(textField: specialistsTextField, text: L10n.chooseSpecialists)
        setupTextField(textField: cityTextField, text: L10n.chooseCity)
        setupTextField(textField: regionTextField, text: L10n.chooseRegion)
        setupTextField(textField: companiesTextField, text: L10n.chooseCompanies)
        setupTextField(textField: doctorTextField, text: L10n.doctorName)
    }
}

// MARK:- Private Methods
extension ServicesSearchView {
    private func setupLabel(label: UILabel, text: String, fontType: FontType){
        label.text = text
        label.textColor = .white
        if fontType == .bold {
            label.font = FontFamily.PTSans.bold.font(size: 40)
        } else {
            label.font = FontFamily.PTSans.regular.font(size: 20)
        }
    }
    private func setupTextField(textField: UITextField, text: String){
        textField.backgroundColor = .white
        textField.font = FontFamily.PTSans.regular.font(size: 20)
        textField.attributedPlaceholder = NSAttributedString(string: text,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    private func setupView(view: UIView){
        view.backgroundColor = .darkRoyalBlue
        view.layer.cornerRadius = 10
    }
}
