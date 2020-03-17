//
//  HomeContract.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
import CoreData
protocol IHomeView : IBaseView {
    
    func renderHomeWithMovies(movies : [Movie]);
     func renderHomeWithMoviesCD();
}


protocol IHomePresenter {
    
    func getMovies()
    func onSuccess(movies : [Movie])
    func onFail(check:Bool)
}


protocol IHomeManager {
    
    func getMovies(homePresenter : IHomePresenter)
    
}


