//
//  VoucherViewController.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/21/20.
//

import UIKit

protocol VoucherDelegate: class {
    func voucherCode(code: String, patientName: String)
}

class VoucherViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var voucherView: VoucherView!
    
    // MARK: - Properties
    private var viewModel: VoucherViewModelProtocol!
    weak var delegate: VoucherDelegate!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        voucherView.setup()
    }
    
    // MARK:- Public Methods
    class func create() -> VoucherViewController {
        let voucherVC: VoucherViewController = VoucherViewController()
        return voucherVC
    }

    // MARK:- Actions
    @IBAction func dismissAlert(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func switchButton(_ sender: UISwitch) {
        switch sender.tag{
        case 0 :
            voucherView.setupVoucherSwitch(on: sender.isOn)
        case 1:
            voucherView.setupNameSwitch(on: sender.isOn)
        default:
            break
        }
    }
    @IBAction func continueToConfirmBtnTapped(_ sender: UIButton) {
        if voucherView.switchVoucherButton.isOn{
            if  voucherView.codeTextField.text.isBlank{
                self.showAlert(type: .failButton, title: L10n.sorryYouHaveToEnterVoucher, message: "")
                return
            }
        } else if voucherView.switchNameButton.isOn {
            if voucherView.nameTextField.text.isBlank {
                self.showAlert(type: .failButton, title: L10n.sorryYouHaveToEnterPatientName, message: "")
                self.showAlert(type: .failButton, title: L10n.sorry, message: L10n.youHaveToEnterVoucher)
                return
            }
        }
        self.dismiss(animated: false) {
            self.delegate.voucherCode(code: self.voucherView.codeTextField.text ?? "", patientName: self.voucherView.nameTextField.text ?? "")
        }
    }
}
