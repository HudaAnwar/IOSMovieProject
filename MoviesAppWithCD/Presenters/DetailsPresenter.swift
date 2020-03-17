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

import Foundation
//
//  HomePresenter.swift
//  MVPDemo
//
//  Created by Mohamed Saeed on 1/12/19.
//  Copyright © 2019 Mohamed Saeed. All rights reserved.
//


class DetailsPresnter: IDetailPresenter {
  
    
    var detailView : IDetailView
    
    
    init(withDetailView detailView : IDetailView) {
        
        
        self.detailView = detailView
        
    }
    
    
    func getVideos(id:Int) {
        detailView.showLoading()
        let detailModel = DetailModel(pres: self)
        
        detailModel.getVideos(id: id)
        
    }
    
    func onSuccess(videos: [Videos]) {
        detailView.hideLoading()
        detailView.renderDetailWithVideos(videos: videos)
    }
    
    func onFail(errorMessgae: String) {
        
        detailView.hideLoading()
        detailView.showErrorMessage(errorMessage: errorMessgae)
    }
    
    
    
    
}
