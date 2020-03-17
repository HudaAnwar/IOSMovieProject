//
//  DetailsPresenter.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation

//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//



class ReviewsPresnter: IReviewPresenter {
    
    
    var reviewView : IReviewView
    
    
    init(withReviewView reviewView : IReviewView) {
        
        
        self.reviewView = reviewView
        
    }
    
    
    func getReview(id: Int) {
        reviewView.showLoading()
        let reviewModel = ReviewsModel(pres: self)
        reviewModel.getReviews(id: id)
        
    }
    
    func onSuccess(reviews: [Reviews]) {
        reviewView.hideLoading()
        reviewView.renderTableWithReviews(reviews: reviews)
    }
    
    func onFail(errorMessgae: String) {
        
        reviewView.hideLoading()
        reviewView.showErrorMessage(errorMessage: errorMessgae)
    }
    
    
    
    
}
