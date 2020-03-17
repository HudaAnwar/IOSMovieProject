//
//  IDetailsProtocol.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation

protocol IDetailView : IBaseView {
    
    func renderDetailWithVideos(videos : [Videos]);
    
}

protocol IDetailPresenter {
    
    func getVideos(id:Int)
    func onSuccess(videos : [Videos])
    func onFail(errorMessgae : String)
}
protocol IDetailManager {
    
    func getVideos(detailPresenter : IDetailPresenter)
    
}
