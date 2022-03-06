//
//  RequestVC.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/20/20.
//

import UIKit

protocol RequestVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func showSuccess(with message: String)
    func showError(with message: String)
}
class RequestVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var requestView: RequestView!

    // MARK: - Properties
    static let ID = "\(RequestVC.self)"
    private var viewModel: RequestViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        requestView.setup(type: viewModel.requestType())
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavBar(type: viewModel.requestType())
    }
    
    // MARK:- Public Methods
    class func create(type: RequestType) -> RequestVC {
        let requestVC: RequestVC = UIViewController.create(storyboardName: Storyboards.settings, identifier: RequestVC.ID)
        requestVC.viewModel = RequestViewModel(view: requestVC, type: type)
        return requestVC
    }
    
    // MARK:- Actions
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        viewModel.getRequestData(name: requestView.nameTextField.text, email: requestView.emailTextField.text, mobile: requestView.mobileTextField.text, message: requestView.messageTextView.text)
    }
}
// MARK:- TextView Delegate
extension RequestVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        removePlaceholder(textView)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        addPlaceholder(textView)
    }
}

//MARK:- Conform Protocol
extension RequestVC: RequestVCProtocol{
    func showLoader() {
        self.requestView.showLoader()
    }
    func hideLoader() {
        self.requestView.hideLoader()
    }
    func showSuccess(with message: String) {
        showAlert(type: .successButton, title: message, message: ""){
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func showError(with message: String) {
        showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    
}
// MARK:- Private Methods
extension RequestVC {
    private func setupDelegates(){
        requestView.messageTextView.delegate = self
    }
    private func removePlaceholder(_ textView: UITextView) {
        if textView.text == viewModel.textViewPlaceholder() {
            textView.text = nil
        }
    }
    private func addPlaceholder(_ textView: UITextView) {
        if textView.text.isBlank {
            textView.text = viewModel.textViewPlaceholder()
        }
    }
    private func setupNavBar(type: RequestType){
        if type == .nurse{
            addSettingsButton()
        }
        setBackgroundImage()
        setViewControllerTitle(to: viewModel.navigationTitle())
        addBackButton()
        navigationController?.navigationBar.isHidden = false
    }
}
