//
//  ServicesSearchVC.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/18/20.
//

import UIKit

protocol ServicesSearchVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func showAlert(message: String)
}

class ServicesSearchVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var servicesSearchView: ServicesSearchView!
    
    // MARK: - Properties
    private var selectedTextField: UITextField!
    var viewModel: ServicesSearchViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        servicesSearchView.setup()
        viewModel.getDoctorsQueryParameters()
        self.setBackgroundImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupNav()
    }
    
    // MARK:- Public Methods
    class func create(id: Int) -> ServicesSearchVC {
        let servicesSearchVC: ServicesSearchVC = UIViewController.create(storyboardName: Storyboards.main, identifier: "\(ServicesSearchVC.self)")
        servicesSearchVC.viewModel = ServicesSearchViewModel(view: servicesSearchVC, mainCategoteID: id)
        return servicesSearchVC
    }
    
    // MARK:- Actions
    @IBAction func findDoctorBtnTapped(_ sender: IDEHospitalButton) {
        let queryData = getQueryData()
        let searchResultVC = SearchResultVC.create(queryData: queryData)
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

// MARK:- TextField Delegate
extension ServicesSearchVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldTapped(textField: textField)
    }
}

// MARK:- Private Methods
extension ServicesSearchVC {
    private func textFieldTapped(textField: UITextField) {
        selectedTextField = textField
    }
    // MARK:- Picker
    private func setupPicker() {
        let pickerView = UIPickerView()
        let toolbar = setupPickerToolbar()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        for textField in [servicesSearchView.specialistsTextField, servicesSearchView.cityTextField, servicesSearchView.regionTextField, servicesSearchView.companiesTextField] {
            textField?.delegate = self
            textField?.inputView = pickerView
            textField?.inputAccessoryView = toolbar
        }
    }
    private func setupPickerToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelHandler))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: L10n.done, style: .plain, target: self, action: #selector(doneHandler))
        toolbar.setItems([cancelButton, flexButton, doneButton], animated: false)
        
        return toolbar
    }
    @objc private func doneHandler() {
        let picker = selectedTextField.inputView as! UIPickerView
        let selectedRow = picker.selectedRow(inComponent: 0)
        let selection = viewModel.title(for: selectedTextField, row: selectedRow)
        if selectedTextField == servicesSearchView.cityTextField {
            servicesSearchView.regionTextField.text = ""
        }
        selectedTextField.text = selection
        // Dismiss picker
        selectedTextField.resignFirstResponder()
        // Reset picker selection to the first row
//        picker.selectRow(0, inComponent: 0, animated: false)
    }
    @objc private func cancelHandler() {
        selectedTextField.resignFirstResponder()
    }
    private func getQueryData() -> DoctorsQuery {
        var dataQuery = viewModel.getDataQuery()
        dataQuery.doctorName = servicesSearchView.doctorTextField.text
        return dataQuery
    }
    private func setupNav(){
        setupNavigationBar()
        setViewControllerTitle(to: L10n.servicesSearch)
        addSettingsButton()
        addBackTooRootButton()
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK:- UIPickerView DataSource
extension ServicesSearchVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfRows(for: selectedTextField)
    }
}

// MARK:- UIPickerView Delegate
extension ServicesSearchVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.title(for: selectedTextField, row: row)
    }
}

//MARK:- Conform Protocol
extension ServicesSearchVC: ServicesSearchVCProtocol {
    func showAlert(message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func showLoader() {
        servicesSearchView?.showLoader()
    }
    func hideLoader() {
        servicesSearchView?.hideLoader()
    }
}
