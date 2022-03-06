//
//  ReviewViewModel.swift
//  IDE Hospital
//
//  Created by Ibrahim El-geddawy on 10/19/20.
//

import Foundation

protocol ReviewViewModelProtocol {
    func submitReview(review: String, rating: Int)
}

class ReviewViewModel{
    
    // MARK:- Private Properties
    private weak var view: ReviewVCProtocol?
    private var id: Int!
    private var rating = 0
    
    // MARK:- Init
    init(view: ReviewVCProtocol, id: Int){
        self.view = view
        self.id = id
    }
}

//MARK:- Conform Protocol
extension ReviewViewModel: ReviewViewModelProtocol{
    func submitReview(review: String, rating: Int) {
        if validate(review: review, rating: rating){
            let review = Review(id: nil, rating: self.rating, commentedBy: nil, comment: review)
            saveUserReview(review: review)
        }
    }
}

//MARK:- Private Methods
extension ReviewViewModel {
    private func validate(review: String?, rating: Int?) -> Bool {
        if review.isBlank && rating == 0{
            view?.handleError(with: L10n.reviewAcceptance)
            return false
        }
        self.rating = rating ?? 5
        if rating == 0 && !review.isBlank{
            self.rating = 5
        }
        return true
    }
    private func saveUserReview(review: Review){
        APIManager.postReview(doctorID: self.id, comment: review.comment!, rating: review.rating!) {
            [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let response):
                switch response.code {
                case 202:
                    self.view?.handleSubmittedSuccessfully()
                default:
                    if let errorMessages = response.errors?.formattedErrors(){
                        self.view?.handleError(with: errorMessages)
                    }
                }
            case .failure(let error):
                self.view?.handleError(with: error.localizedDescription)
            }
        }
        self.view?.hideLoader()
    }
}
