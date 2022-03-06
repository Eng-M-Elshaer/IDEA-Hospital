//
//  SettingsVC.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

enum ComeFrom {
    case settings
    case tabbar
}

class SettingsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var settingsView: SettingsView!
    
    // MARK: - Properties
    static let ID = "\(SettingsVC.self)"

    // MARK:- Private Properties
    private let loggedinItems = [
        (L10n.editProfile, Asset.user2.image),
        (L10n.favourite, Asset.heartblue.image),
        (L10n.bookedAppointments, Asset.calendar2.image),
//        (L10n.lang, Asset.global.image),
        (L10n.aboutUS, Asset.about.image),
        (L10n.contactUs, Asset.contact.image),
        (L10n.share, Asset.share.image),
        (L10n.termsAndConditions, Asset.sheet.image),
        (L10n.logout, Asset.login.image)
    ]
    private let loggedoutItems = [
        (L10n.login, Asset.login.image),
//        (L10n.lang, Asset.global.image),
        (L10n.aboutUS, Asset.about.image),
        (L10n.contactUs, Asset.contact.image),
        (L10n.share, Asset.share.image),
        (L10n.termsAndConditions, Asset.sheet.image)
    ]
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.setup()
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupNavigationBar()
        addBackButton()
        self.tabBarController?.tabBar.isHidden = false
        
    }

    // MARK:- Public Methods
    class func create() -> SettingsVC {
        let settingsVC: SettingsVC = UIViewController.create(storyboardName: Storyboards.settings, identifier: "\(SettingsVC.self)")
        return settingsVC
    }
}

// MARK:- TableView DataSource
extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaultsManager.shared().isLoggedIn{
            return loggedinItems.count
        }
        return loggedoutItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(in: tableView, at: indexPath)
    }
}

// MARK:- TableView Delegate
extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelectedRow(at: indexPath)
    }
}

// MARK:- Private Methods
extension SettingsVC {
    private func setupDelegates() {
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
    }
    private func setupCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.ID, for: indexPath) as! SettingsTableViewCell
        if UserDefaultsManager.shared().isLoggedIn{
            cell.item = loggedinItems[indexPath.row]
        }else{
            cell.item = loggedoutItems[indexPath.row]
        }
        return cell
    }
    private func handleSelectedRow(at indexPath: IndexPath) {
        var vc: UIViewController?
        if UserDefaultsManager.shared().isLoggedIn{
            switch indexPath.row {
            case 0:
                vc = EditProfileVC.create()
            case 1:
                vc = FavoriteVC.create(comeFrom: .settings)
            case 2:
                vc = MyAppointmentsVC.create(comeFrom: .settings)
//            case 3:
//                self.showLanguageAlert()
            case 3:
                vc = StaticContentVC.create(type: .aboutus)
            case 4:
                vc = RequestVC.create(type: .contactus)
            case 5:
                shareApp()
            case 6:
                vc = StaticContentVC.create(type: .termsAndConditions)
            case 7:
                self.showLogoutAlert()
            default:
                print("Cell \(indexPath.row) tapped")
            }
        }else{
            switch indexPath.row {
            case 0:
                vc = SignInVC.create()
//            case 1:
//                showLanguageAlert()
            case 1:
                vc = StaticContentVC.create(type: .aboutus)
            case 2:
                vc = RequestVC.create(type: .contactus)
            case 3:
                shareApp()
            case 4:
                vc = StaticContentVC.create(type: .termsAndConditions)
            default:
                print("Cell \(indexPath.row) tapped")
            }
        }
        
        if let vc = vc {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    private func showLanguageAlert() {
        let alert = UIAlertController(title: L10n.language, message: nil, preferredStyle: .actionSheet)
        let englishAction = UIAlertAction(title: "English", style: .default)
        alert.addAction(englishAction)
        
        let arabicAction = UIAlertAction(title: "Arabic", style: .default) { [weak self] UIAlertAction in
            guard let self = self else { return }
            self.showAlert(type: .failButton, title: L10n.sorry, message: "Arabic Soon")
        }
        alert.addAction(arabicAction)
        
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    private func showLogoutAlert() {
        showAlert(type: .twoButtons, title:L10n.logout, message: L10n.logoutMessage, buttonTitle: L10n.yes) {
            self.dismiss(animated: true) {
                UserDefaultsManager.shared().isLoggedIn = false
                UserDefaultsManager.shared().token = nil
                AppRoot.createRoot()
            }
        }
    }
    private func shareApp(){
        let text = "Here Signup "
        //TODO: add ReferralCode , and App link
//        let link = "https://apps.apple.com/app/id{{appId}}"
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    private func setupNavBar() {
        // NavBar Appearance
        setViewControllerTitle(to: L10n.settings)
        setupNavigationBar()
        self.navigationController?.navigationBar.backgroundColor = .darkRoyalBlue
        addBackButton(isWhite: true)
    }
}
