//
//  MainCell.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit
import SDWebImage

class MainCell: UICollectionViewCell {

    // MARK:- Outlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK:- Public Methods
    func configCell( categore: MainCategories){
        self.imageView.sd_setImage(with: URL(string: categore.image), placeholderImage: Asset.user.image)
        self.view.backgroundColor = UIColor(hexString: categore.color )
        self.titleLabel.text = categore.name
    }
}

// MARK:- Private Methods
extension MainCell {
    private func setupUI(){
        setupLabel()
        setupRadius()
    }
    private func setupLabel(){
        titleLabel.font = FontFamily.PTSans.bold.font(size: 15)
        titleLabel.textColor = .white
    }
    private func setupRadius(){
        layer.cornerRadius = 10
    }
}
