//
//  IDetailsProtocol.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation

protocol IReviewView : IBaseView {
    
    func renderTableWithReviews(reviews : [Reviews]);
    
}

protocol IReviewPresenter {
    
    func getReview(id:Int)
    func onSuccess(reviews : [Reviews])
    func onFail(errorMessgae : String)
}
protocol IReviewManager {
    
    func getReviews(reviewPresenter : IReviewPresenter)
    
}
