//
//  MyAppointmentsTableViewCell.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

protocol MyAppointmentCellDelegate: class{
    func deleteAppointment(at index: Int)
    func viewMap(at index: Int)
}

class MyAppointmentsTableViewCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var doctorDecsriptionLabel: UILabel!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var viewOnMapBtn: UIButton!
    @IBOutlet weak var appointmentTimeLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    
    // MARK: - Properties
    private var cellIndex: Int = -1
    static let ID = "\(MyAppointmentsTableViewCell.self)"
    weak var delegate: MyAppointmentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        selectionStyle = .none
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Public Methods
    func configure(myAppointment: MyAppointment, index: Int){
        self.cellIndex = index
        self.doctorNameLabel.text = myAppointment.doctor?.name ?? ""
        self.doctorDecsriptionLabel.text = myAppointment.doctor?.bio
        self.doctorImageView.sd_setImage(with: URL(string: myAppointment.doctor?.image ?? ""), placeholderImage: Asset.user.image)
        self.reviewsCountLabel.text = "\(myAppointment.doctor?.reviewsCount ?? 0)" + " " + L10n.reviews
        self.appointmentTimeLabel.text = formattedDate(myAppointment.appointment ?? 0)
        self.setupStars(rating: myAppointment.doctor?.rating ?? 0)
    }
    
    // MARK:- Actions
    @IBAction func viewOnMapBtnPressed(_ sender: UIButton) {
        delegate?.viewMap(at: cellIndex)
    }
    @IBAction func cancelAppointmentPressedBtn(_ sender: UIButton) {
        delegate?.deleteAppointment(at: cellIndex)
    }
    
}
//MARK:- Private Methods
extension MyAppointmentsTableViewCell{
    private func setupUI(){
        setupImage()
        setupLabels()
        setupViewMapButton()
    }
    private func setupImage(){
        self.doctorImageView.cornerStylish(color: .darkRoyalBlue, borderWidth: 2, cornerRadius: doctorImageView.frame.width/2)
        self.doctorImageView.contentMode = .scaleAspectFit
    }
    private func setupLabel(label: UILabel, font: UIFont = FontFamily.PTSans.regular.font(size: 10), textColor: UIColor = .white, line: Int = 0){
        label.font = font
        label.textColor = textColor
        label.numberOfLines = line
    }
    private func setupLabels(){
        setupLabel(label: doctorNameLabel, font: FontFamily.PTSans.bold.font(size: 15))
        setupLabel(label: doctorDecsriptionLabel, font: FontFamily.PTSans.regular.font(size: 10))
        setupLabel(label: appointmentTimeLabel, font: FontFamily.PTSans.regular.font(size: 13))
        setupLabel(label: reviewsCountLabel, font: FontFamily.PTSans.regular.font(size: 10))
    }
    private func setupViewMapButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.PTSans.regular.font(size: 13),
            .foregroundColor: UIColor.white
        ]
        let attributedString = NSAttributedString(string: L10n.viewOnMap, attributes: attributes)
        viewOnMapBtn.tintColor = .white
        viewOnMapBtn.setImage(Asset.pin.image, for: .normal)
        viewOnMapBtn.setAttributedTitle(attributedString, for: .normal)
        cancelBtnOutlet.tintColor = .white
        cancelBtnOutlet.setImage(Asset.icClose.image, for: .normal)
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
    private func formattedDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy \n \n HH:mm a"
        return dateFormatter.string(from: date)
    }
}
