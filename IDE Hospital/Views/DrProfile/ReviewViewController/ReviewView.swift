//
//  ReviewView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

class ReviewView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var submitReviewBtn: IDEHospitalButton!
    @IBOutlet weak var reviewtitleLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet var starsButtons: [UIButton]!
    @IBOutlet weak var commentTextField: IDEHospitalTextField!
      
    // MARK:- Public Methods
    func setup(){
        commentTextField.isAddComment = true
        setupLabels()
        setupReviewTextField()
        setupStarsButtons()
        setupButtons()
    }
    func getRating() -> Int {
        for button in starsButtons {
            if !button.isSelected {
                return button.tag
            }
        }
        return 5
    }
}
// MARK:- Private Methods
extension ReviewView {
    private func setupLabels() {
        reviewtitleLabel.text = L10n.rateYourExperience
        reviewtitleLabel.textColor = .white
        reviewtitleLabel.font = FontFamily.PTSans.bold.font(size: 14)
    }
    private func setupReviewTextField() {
        commentTextField.backgroundColor = .clear
        commentTextField.font = FontFamily.PTSans.bold.font(size: 12)
        commentTextField.textColor = UIColor.white
        commentTextField.addImage(image: UIImage())
        commentTextField.addLineView()
        commentTextField.setupPlaceholder(text: L10n.addComent)
    }
    private func setupButtons() {
        submitReviewBtn.setup(title: L10n.submitReview, fontSize: 20)
    }
    private func setupStarsButtons() {
        starsButtons = starsButtons.sorted { $0.tag < $1.tag }
        
        for button in starsButtons {
            button.setImage(Asset.emptyStar.image, for: .normal)
            button.setImage(Asset.rate.image, for: .selected)
            button.adjustsImageWhenHighlighted = false
        }
    }
}
