//
//  HomePresenter.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
import CoreData


class HomePresnter: IHomePresenter {
    
    
    var homeView : IHomeView
    
    
    init(withHomeView homeView : IHomeView) {
        
        
        self.homeView = homeView
        
    }
    
    
    func getMovies() {

        homeView.showLoading()
        let homeModel = HomeModel(pres: self)
        
        homeModel.getMovies()


    }
    
    func onSuccess(movies: [Movie]) {
        
        homeView.hideLoading()
        homeView.renderHomeWithMovies(movies: movies)
    }
   
    func onFail(check:Bool) {
        
        homeView.hideLoading()
       
        homeView.renderHomeWithMoviesCD()
        homeView.showErrorMessage(errorMessage: "error")
    }
    
    
    
    
}
