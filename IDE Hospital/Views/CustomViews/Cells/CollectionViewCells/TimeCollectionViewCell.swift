//
//  TimeCollectionViewCell.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Properties
    static let ID = "\(TimeCollectionViewCell.self)"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        setupLabel()
    }
    
    override var isSelected: Bool {
        didSet { setState() }
    }

    // MARK:- Public Methods
    func configure(time: Times){
        if time.booked ?? false{
//            self.isSelected = true
            self.isUserInteractionEnabled = false
            self.backgroundColor = .unselectButtonColor
        }else{
            self.isSelected = false
            self.isUserInteractionEnabled = true
            self.backgroundColor = .niceBlue
        }
        self.timeLabel.text = formattedDate(time.time ?? 0)
    }
}

//MARK:- Private Methods
extension TimeCollectionViewCell{
    private func setState() {
        backgroundColor = isSelected ? .darkRoyalBlue : .niceBlue
    }
    private func setupLabel(){
        self.timeLabel.textAlignment = .center
        self.timeLabel.textColor = .white
        self.timeLabel.font = FontFamily.PTSans.bold.font(size: 12)
    }
    private func formattedDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }
}
