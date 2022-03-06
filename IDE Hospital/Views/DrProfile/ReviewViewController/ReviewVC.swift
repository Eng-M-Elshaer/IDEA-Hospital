//
//  ReviewViewController.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import UIKit

protocol ReviewVCProtocol: UIViewController {
    func showLoader()
    func hideLoader()
    func handleError(with message: String)
    func handleSubmittedSuccessfully()
}

class ReviewVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var reviewView: ReviewView!
    
    // MARK: - Properties
    static let ID = "\(ReviewVC.self)"
    private var viewModel: ReviewViewModelProtocol!
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewView.setup()
        setupNavBar()
    }
    
    // MARK:- Actions
    @IBAction func starBtnTapped(_ sender: UIButton) {
        handleStarButtonTapped(sender.tag)
    }
    @IBAction func submitReviewBtnTapped(_ sender: UIButton) {
        let review = reviewView.commentTextField.text?.trimmed ?? ""
        let rating = reviewView.getRating()
        viewModel.submitReview(review: review, rating: rating)
    }
    
    // MARK:- Public Methods
    class func create(id: Int) -> ReviewVC {
        let reviewVC: ReviewVC = UIViewController.create(storyboardName: Storyboards.drProfile, identifier: self.ID)
        reviewVC.viewModel = ReviewViewModel(view: reviewVC, id: id)
        return reviewVC
    }
}

//MARK:- Conform Protocol
extension ReviewVC: ReviewVCProtocol{
    func showLoader() {
        self.reviewView.showLoader()
    }
    func hideLoader() {
        self.reviewView.hideLoader()
    }
    func handleError(with message: String) {
        self.showAlert(type: .failButton, title: L10n.sorry, message: message)
    }
    func handleSubmittedSuccessfully() {
        self.showAlert(type: .successButton, title: L10n.reviewSuccess, message: ""){
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK:- Private Methods
extension ReviewVC {
    private func handleStarButtonTapped(_ tag: Int) {
        for index in 0...tag {
            reviewView.starsButtons[index].isSelected = true
        }
        if tag == 4 { return }
        for index in (tag + 1)...4 {
            reviewView.starsButtons[index].isSelected = false
        }
    }
    private func setupNavBar(){
         setupNavigationBar()
         setViewControllerTitle(to: L10n.review)
         addBackButton()
         addSettingsButton()
         setBackgroundImage()
    }
}
