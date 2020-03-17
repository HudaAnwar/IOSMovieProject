//
//  BaseContract.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation

protocol IBaseView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(errorMessage : String)
}


