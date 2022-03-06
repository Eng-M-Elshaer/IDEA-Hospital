//
//  UIViewController+NavBar.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/15/20.
//

import UIKit

extension UIViewController {
    func setupNavigationBar() {
        // NavBar Appearance
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        // Remove shadow
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .navigationColor
    }
    func setViewControllerTitle(to title:String, fontColor: UIColor = .white) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 25))
        titleLabel.font = FontFamily.PTSans.bold.font(size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.textColor = fontColor
        self.navigationItem.titleView = titleLabel
    }
    func addSettingsButton(isWhite: Bool = false) {
        let settings = Asset.settings.image
        let settingsButtonItem = UIBarButtonItem.init(image: settings, style: .done, target: self, action: #selector(settingsButtonTapped))
        if isWhite{
            settingsButtonItem.tintColor = .white
        }else{
            navigationController?.navigationBar.tintColor = .navButtonColor
        }
        self.navigationItem.rightBarButtonItem = settingsButtonItem
    }
    func addLangButton() {
        let lang = LanguageManager.shared().getCurrentLanguage()
        var langButton: UIImage!
        if lang == .en {
            langButton = Asset.arabicButton.image
        } else {
            langButton = Asset.english.image
        }
        let langButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(langButtonTapped))
        langButtonItem.setBackgroundImage(langButton, for: .normal, barMetrics: .default)
        self.navigationItem.rightBarButtonItem = langButtonItem
    }
    func addBackButton(isWhite: Bool = false) {
        var backImage = Asset.back2.image
        if LanguageManager.shared().isRTL() {
            backImage = backImage.rotate(radians: .pi)
        }
        if isWhite{
            navigationController?.navigationBar.tintColor = .white
        }else{
            navigationController?.navigationBar.tintColor = .navButtonColor
        }
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action:  #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    func addBackTooRootButton() {
        var backImage = Asset.back2.image
        if LanguageManager.shared().isRTL() {
            backImage = backImage.rotate(radians: .pi)
        }
        navigationController?.navigationBar.tintColor = .navButtonColor
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action:  #selector(backButtonPressAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
}

//MARK:- Actions
extension UIViewController {
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsVC.create()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    @objc private func langButtonTapped() {
        if LanguageManager.shared().isRTL() {
            LanguageManager.shared().setLanguage(to: .en)
        } else {
            LanguageManager.shared().setLanguage(to: .ar)
        }
        AppRoot.createRoot()
    }
    @objc func backButtonPressAction() {
        AppRoot.createRoot()
    }
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
