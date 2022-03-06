//
//  TabBarVC.swift
//  IUMAK-iOS
//
//  Created by Mohamed Elshaer on 7/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    // MARK: - Properties
    let searchNavigation = UINavigationController()
    let favoriteNavigation = UINavigationController()
    let scheduleNavigation = UINavigationController()
    var mainID: Int = 0 {
        didSet {
            self.setViewControllers()
        }
    }
        
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarView()
        self.tabBar.tintColor = .black
    }
    
    // MARK:- Private Methods
    private func setupTabBarView(){
        tabBar.backgroundColor = .navigationColor
        tabBar.barTintColor = .navigationColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }
    private func setServicesSearchVCTab() {
        let servicesSearchVC = ServicesSearchVC.create(id: mainID)
        servicesSearchVC.tabBarItem.image = Asset.search.image
        servicesSearchVC.tabBarItem.title = L10n.search
        searchNavigation.viewControllers = [servicesSearchVC]
    }
    private func setMyFavoriteVCTab() {
        let myFavoriteVC = FavoriteVC.create(comeFrom: .tabbar)
        myFavoriteVC.tabBarItem.image = Asset.tabHeart.image
        myFavoriteVC.tabBarItem.title = L10n.favourite
        favoriteNavigation.viewControllers = [myFavoriteVC]
    }
    private func setScheduleVCTab() {
        let scheduleVC = MyAppointmentsVC.create(comeFrom: .tabbar)
        scheduleVC.tabBarItem.image = Asset.calendar.image
        scheduleVC.tabBarItem.title = L10n.schedule
        scheduleNavigation.viewControllers = [scheduleVC]
    }
    private func setViewControllers() {
        setServicesSearchVCTab()
        setMyFavoriteVCTab()
        setScheduleVCTab()

        self.viewControllers = [searchNavigation, favoriteNavigation, scheduleNavigation]
        self.selectedIndex = 0
        for vc in self.viewControllers! {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        }
    }
}
