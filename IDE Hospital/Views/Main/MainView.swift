//
//  MainView.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit

class MainView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainCategoriesColledtionView: UICollectionView!
    @IBOutlet weak var mainCategoriesColledtionViewHight: NSLayoutConstraint!
    
    // MARK:- Public Methods
    func setup(){
        logoImageView.image = Asset.logo.image
        setupTitleLabel()
        setupMainCategoriesColledtionView()
        registerNib()
    }
}

// MARK:- Private Methods
extension MainView {
    private func setupTitleLabel(){
        titleLabel.font = FontFamily.PTSans.bold.font(size: 20)
        titleLabel.textColor = .white
        titleLabel.text = L10n.idea
    }
    private func registerNib(){
        let mainCell = UINib(nibName: CustomCells.mainCell, bundle:nil)
        mainCategoriesColledtionView.register(mainCell, forCellWithReuseIdentifier: CustomCells.mainCell)
    }
    private func setupMainCategoriesColledtionView(){
        mainCategoriesColledtionView.backgroundColor = .clear
        mainCategoriesColledtionView.showsVerticalScrollIndicator = false
        mainCategoriesColledtionView.layoutIfNeeded()
        
        //cell size
        let numOfCells: CGFloat = 2.0
        let margin: CGFloat = 26
        let padding: CGFloat = 10
        let paddingSpace = (padding * (numOfCells - 1))
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (paddingSpace + 2 * margin)
        let cellWidth = availableWidth / numOfCells
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        mainCategoriesColledtionViewHight.constant = (cellWidth * 2) + padding
        mainCategoriesColledtionView.collectionViewLayout = layout
    }
}
