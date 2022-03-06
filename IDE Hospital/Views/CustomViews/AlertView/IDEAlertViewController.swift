//
//  AlertViewController.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

enum IDEAlertTypes {
    case confirmButton
    case twoButtons
    case successButton
    case failButton
}

class IDEAlertViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var alertView: AlertView!
    
    // MARK:- Properties
    var type: IDEAlertTypes!
    var message: String!
    var buttonTitle: String?
    var completion: (()->Void)?
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.setup(type: type, title: title!, message: message, buttonTitle: buttonTitle!)
    }
    
    // MARK:- Public Methods
    class func create(type: IDEAlertTypes) -> IDEAlertViewController {
        let iumakAlertVC = IDEAlertViewController()
        return iumakAlertVC
    }

    // MARK:- Actions
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        if let completion = completion{
            completion()
        }
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismissAlert()
    }
}

// MARK:- Private Methods
extension IDEAlertViewController {
    private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}

