//
//  SettingsTableViewCell.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    // MARK: - Properties
    static let ID = "\(SettingsTableViewCell.self)"
    var item: (text: String, image: UIImage)! {
        didSet { configureCell() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }
}

// MARK:- Private Methods
extension SettingsTableViewCell{
    private func setupUI(){
        backgroundColor = .clear
        selectionStyle = .none
        titleLabel.textColor = .darkRoyalBlue
        titleLabel.font = FontFamily.PTSans.regular.font(size: 20)
        itemImageView.tintColor = .darkRoyalBlue
        arrowImageView.tintColor = .darkRoyalBlue
        arrowImageView.image = Asset.next2.image
    }
    private func configureCell() {
        titleLabel.text = item.text
        itemImageView.image = item.image
    }
}
