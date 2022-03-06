//
//  DrProfileView.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/18/20.
//

import UIKit
import SDWebImage

class DrProfileView: UIView {
    
    //Header
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var favoriteBtnOutlet: UIButton!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewMeButtonOutlet: UIButton!
    @IBOutlet weak var doctorDescriptionLabel: UILabel!
    // Appointments Time
    @IBOutlet weak var appointmentsDateView: UIView!
    @IBOutlet weak var noAppointmentsLabel: UILabel!
    @IBOutlet weak var previousAppointmentBtnOutlet: UIButton!
    @IBOutlet weak var nextAppointmentBtnOutlet: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var appointmentsCollectionView: UICollectionView!
    @IBOutlet weak var bookNowButtonOutlet: IDEHospitalButton!
    //Footer
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var doctorProfileContainerView: UIView!
    @IBOutlet weak var DdctorProfileLabel: UILabel!
    @IBOutlet weak var reviewContainerView: UIView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    //Doctor Profile Outlets
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var secondDescriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationBtnOutlet: UIButton!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    @IBOutlet weak var examinationFeesLabel: UILabel!
    @IBOutlet weak var servicesTagsLabel: UILabel!
    @IBOutlet weak var footerContainerView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    // MARK:- Public Methods
    func setupUI(){
        self.localizeSubViews()
        self.backgroundColor = .clear
        self.setupImageView()
        self.setupHeaderLabels()
        self.setupFavButton()
        setupButtonsContainerView()
        setupFooterLabels()
        setupCollectionView()
        setupBookButton()
        setupDateView()
        setupDoctorProfileButton()
        self.setupShowonMapButton()
        self.setupTableView()
        setupTapReviewButton()
        setupViewMapButton()
        setupNoResultLabel()
        showResult()
    }
    func setup(drProfile: DoctorProfile){
        doctorNameLabel.text = drProfile.name
        addressLabel.text = drProfile.address
        self.setupFavButton(isFav: drProfile.isFavorited ?? false)
        self.specialityLabel.text = drProfile.specialty
        self.doctorDescriptionLabel.text = drProfile.bio
        self.waitingTimeLabel.text = L10n.waitingTime + "\(drProfile.waitingTime ?? 0) " + L10n.minutes
        examinationFeesLabel.text = L10n.examinationFees + "\(drProfile.fees ?? 0) " + L10n.le
        self.secondDescriptionLabel.text = drProfile.secondBio
        setupReviews(count: drProfile.reviewsCount ?? 0)
        self.setupStars(rating: drProfile.rating ?? 0)
        doctorImageView.sd_setImage(with: URL(string: drProfile.image ?? ""), placeholderImage: Asset.user.image)
        servicesTagsLabel.text = comapniesString(companies: drProfile.companies)
    }
    func setupAppointmentLabel(appointment: AppointmentDate) {
        self.dateLabel.text = formattedDate(appointment.date ?? 0) 
    }
    func setupReviews(count: Int){
        let attributedString = NSMutableAttributedString(string: String(format: "%@\n", L10n.reviews), attributes: [.font: FontFamily.PTSans.bold.font(size: 20), .foregroundColor: UIColor.black])
        attributedString.append(NSMutableAttributedString(string: String(format: "%d %@", count,L10n.reviews), attributes: [.font: FontFamily.PTSans.regular.font(size: 12), .foregroundColor: UIColor.purple]))
        self.reviewsLabel.attributedText = attributedString
    }
}

//MARK:- Private Methodes setup Header
extension DrProfileView{
    private func setupImageView(){
        self.doctorImageView.cornerStylish(color: .darkRoyalBlue, borderWidth: 2, cornerRadius: self.doctorImageView.frame.width/2)
        self.doctorImageView.contentMode = .scaleAspectFit
    }
    private func setupHeaderLabels(){
        self.setupLabel(label: doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        self.setupLabel(label: doctorDescriptionLabel, font: FontFamily.PTSans.regular.font(size: 12))
    }
    private func setupLabel(label: UILabel, font: UIFont = FontFamily.PTSans.regular.font(size: 12), textColor: UIColor = .white, line: Int = 0){
        label.font = font
        label.textColor = textColor
        label.numberOfLines = line
    }
    private func setupStars(rating: Int) {
        var starts = rating
        if starts > 5 {
            starts = 5
        } else if starts < 0 {
            starts = 0
        }
        for starIndex in 0...starts - 1 {
            let startImageView = reviewStackView.arrangedSubviews[starIndex] as! UIImageView
            startImageView.image = Asset.rate.image
        }
    }
    private func setupFavButton(isFav:Bool = false){
        self.favoriteBtnOutlet.tintColor = .white
        if !isFav{
            self.favoriteBtnOutlet.setImage(Asset.emptyHeart.image, for: .normal)
        }else{
            self.favoriteBtnOutlet.setImage(Asset.heart.image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    private func setupTapReviewButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.bold.font(size: 12),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: L10n.tapReview, attributes: attributes)
        reviewMeButtonOutlet.setAttributedTitle(attributedString, for: .normal)
    }
}

//MARK:- Appointments
extension DrProfileView{
    private func setupDateView(){
        self.setupLabel(label: dateLabel, font: FontFamily.PTSans.bold.font(size: 12))
        self.dateLabel.textAlignment = .center
        self.previousAppointmentBtnOutlet.setImage(Asset.previous.image, for: .normal)
        self.nextAppointmentBtnOutlet.setImage(Asset.next.image, for: .normal)
        if LanguageManager.shared().isRTL(){
            self.nextAppointmentBtnOutlet.setImage(Asset.previous.image, for: .normal)
            self.previousAppointmentBtnOutlet.setImage(Asset.next.image, for: .normal)
        }
        self.nextAppointmentBtnOutlet.tintColor = .white
        self.previousAppointmentBtnOutlet.tintColor = .white
        self.appointmentsDateView.backgroundColor = .darkRoyalBlue
    }
    private func setupCollectionView(){
        //cell size
        let margin: CGFloat = 23
        let padding: CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (2 * margin)
        let cellWidth = availableWidth/3 - padding
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 25)
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: margin, bottom: 10, right: margin)
        appointmentsCollectionView.collectionViewLayout = layout
        appointmentsCollectionView.backgroundColor = .clear
        let nib = UINib(nibName: TimeCollectionViewCell.ID, bundle: nil)
        appointmentsCollectionView.register(nib, forCellWithReuseIdentifier: TimeCollectionViewCell.ID)
    }
    private func setupBookButton(){
        self.bookNowButtonOutlet.setup(title: L10n.book, fontSize: 12)
        setupUnbooked()
    }
    private func setupNoResultLabel(){
        noAppointmentsLabel.textColor = .white
        noAppointmentsLabel.font = FontFamily.PTSans.bold.font(size: 15)
        noAppointmentsLabel.text = L10n.noAppointmentsFound
    }
    func setupUnbooked(){
        self.bookNowButtonOutlet.backgroundColor = .unselectButtonColor
        self.bookNowButtonOutlet.isEnabled = false
    }
    func setupBook(){
        self.bookNowButtonOutlet.backgroundColor = .darkRoyalBlue
        self.bookNowButtonOutlet.isEnabled = true
    }
    func showNoResult(){
        noAppointmentsLabel.isHidden = false
    }
    func showResult(){
        noAppointmentsLabel.isHidden = true
    }
}

//MARK:- Setup Footer
extension DrProfileView{
    private func setupButtonsContainerView(){
        self.buttonContainerView.roundCorners(corners: [.layerMaxXMinYCorner,.layerMinXMinYCorner], radius: 25)
        self.DdctorProfileLabel.text = L10n.doctorProfile
        DdctorProfileLabel.textAlignment = .center
        reviewsLabel.textAlignment = .center
    }
    private func setupFooterLabels(){
        self.setupLabel(label: DdctorProfileLabel, font: FontFamily.PTSans.bold.font(size: 15), textColor: .black)
        self.setupLabel(label: reviewsLabel, font: FontFamily.PTSans.bold.font(size: 15), textColor: .black)
        setupLabel(label: specialityLabel,textColor: .blackDecription)
        setupLabel(label: secondDescriptionLabel,textColor: .blackDecription)
        setupLabel(label: waitingTimeLabel,textColor: .blackDecription)
        setupLabel(label: examinationFeesLabel,textColor: .blackDecription)
        setupLabel(label: servicesTagsLabel,textColor: .blackDecription)
        setupLabel(label: addressLabel,textColor: .blackDecription)
    }
    private func setupShowonMapButton(){
        self.footerContainerView.backgroundColor = .init(white: 255/255, alpha: 0.76)
        self.reviewTableView.backgroundColor = .clear
        self.scrollview.backgroundColor = .clear
    }
    func setupDoctorProfileButton(){
        self.reviewTableView.isHidden = true
        self.scrollview.isHidden = false
        self.doctorProfileContainerView.backgroundColor = .white
        self.reviewContainerView.backgroundColor = .unselectButtonColor
    }
    func setupReviewsButton(){
        self.reviewTableView.isHidden = false
        self.scrollview.isHidden = true
        self.reviewContainerView.backgroundColor = .white
        self.doctorProfileContainerView.backgroundColor = .unselectButtonColor
    }
    private func setupViewMapButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.bold.font(size: 12),
            .foregroundColor: UIColor.purple
        ]
        let attributedString = NSAttributedString(string: L10n.viewOnMap, attributes: attributes)
        locationBtnOutlet.tintColor = .purple
        locationBtnOutlet.setImage(Asset.icPin.image, for: .normal)
        locationBtnOutlet.setAttributedTitle(attributedString, for: .normal)
    }
    private func setupTableView(){
        let nib = UINib(nibName: ReviewTableViewCell.ID, bundle: nil)
        reviewTableView.register(nib, forCellReuseIdentifier: ReviewTableViewCell.ID)
        self.reviewTableView.backgroundColor = .clear
    }
    private func comapniesString(companies: [String]?) -> String {
        var companiesStrings = ""
        if let companies = companies {
            for company in companies {
                companiesStrings += company + ", "
            }
            return companiesStrings.trimmed
        }
        return "Clinic Only"
    }
    private func formattedDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
