//
//  SearchResultCell.swift
//  IDE Hospital
//
//  Created by Elshaer on 10/15/20.
//

import UIKit
import SDWebImage

enum FontType {
    case bold
    case regular
}

protocol SearchResultCellProtocol: class {
    func handelFavorite(id: Int)
    func goToProfile(id: Int)
    func showAlert()
}

protocol SearchResultCellDelegate: class {
    func favoriteBtnTapped(_ searchCell: SearchResultCell, favoriteButtonTappedFor result: DoctorProfile)
    func bookNowBtnTapped(_ searchCell: SearchResultCell, bookNowBtnTappedFor result: DoctorProfile)
}

class SearchResultCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var bookNowButton: IDEHospitalButton!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageBorderView: UIView!
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    
    // MARK: - Properties
    var result: DoctorProfile?
    weak var delegate: SearchResultCellDelegate?
    var viewModel: SearchResultCellViewModelProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImageView.image = Asset.emptyStar.image
    }
    
    // MARK:- Actions
    @IBAction func favortieBtnTapped(_ sender: UIButton) {
        self.delegate?.favoriteBtnTapped(self, favoriteButtonTappedFor: result!)
    }
    @IBAction func bookNowBtnTapped(_ sender: IDEHospitalButton) {
        self.delegate?.bookNowBtnTapped(self, bookNowBtnTappedFor: result!)
    }
    
    // MARK:- Public Methods
    func cellConfig(result: DoctorProfile){
        doctorImageView.sd_setImage(with: URL(string: result.image ?? ""), placeholderImage: Asset.user.image)
        doctorNameLabel.text = result.name
        reviewCountLabel.text = "\(result.reviewsCount ?? 0) " + L10n.review
        specialtyLabel.text = result.specialty
        setupStars(rating: result.rating ?? 0)
        descriptionLabel.text = result.secondBio
        locationLabel.text = result.address
        timeLabel.text = L10n.waitingTime + " " + "\(result.waitingTime ?? 0) " + L10n.minutes
        feesLabel.text = L10n.examinationFees + " " + "\(result.fees ?? 0) " + L10n.le
        if result.isFavorited ?? false {
            favoriteImageView.image = Asset.heart.image
        } else {
            favoriteImageView.image = Asset.emptyHeart.image
        }
    }
}

// MARK:- Private Methods
extension SearchResultCell {
    private func setupUI(){
        self.view.backgroundColor = .clear
        self.backgroundColor = .clear
        setupBorder()
        setupRadius()
        setLabel(label: doctorNameLabel, fontType: .bold, fontSize: 15)
        setLabel(label: specialtyLabel, fontType: .bold, fontSize: 15)
        setLabel(label: reviewCountLabel, fontType: .regular, fontSize: 10)
        setLabel(label: descriptionLabel, fontType: .regular, fontSize: 12)
        setLabel(label: locationLabel, fontType: .regular, fontSize: 12)
        setLabel(label: timeLabel, fontType: .regular, fontSize: 12)
        setLabel(label: feesLabel, fontType: .regular, fontSize: 12)
        setupButton()
    }
    private func setupBorder(){
        imageBorderView.layer.borderWidth = 1
        imageBorderView.layer.borderColor = UIColor.darkRoyalBlue.cgColor
    }
    private func setupRadius(){
        imageBorderView.layer.cornerRadius = imageBorderView.frame.height / 2
    }
    private func setLabel(label: UILabel, fontType: FontType, fontSize: CGFloat){
        label.textColor = .white
        if fontType == .bold {
            label.font = FontFamily.PTSans.bold.font(size: fontSize)
        } else {
            label.font = FontFamily.PTSans.regular.font(size: fontSize)
        }
    }
    private func setupStars(rating: Int) {
        var starts = rating
        if starts > 5 {
            starts = 5
        } else if starts <= 0 {
           return
        }
        for starIndex in 0...starts - 1 {
            let startImageView = starsStackView.arrangedSubviews[starIndex] as! UIImageView
            startImageView.image = Asset.rate.image
        }
    }
    private func setupButton(){
        bookNowButton.setup(title: L10n.bookNow, fontSize: 12)
    }
    func markAsForavite(){
        if favoriteImageView.image == Asset.emptyHeart.image {
            result?.isFavorited = true
            favoriteImageView.image = Asset.heart.image
        } else {
            result?.isFavorited = false
            favoriteImageView.image = Asset.emptyHeart.image
        }
    }
}
