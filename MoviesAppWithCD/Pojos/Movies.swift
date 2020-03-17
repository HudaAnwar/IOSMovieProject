//
//  Movies.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
class Movie {
    var id:Int = 0
    var title:String = ""
    var popularity:Double = 0.0
    var overview:String = ""
    var poster_path :String = ""
    var vote_average:Double = 0.0
    var release_date:String = ""
    init(){
         id = 0
         title = ""
         popularity = 0.0
         overview = ""
         poster_path  = ""
         vote_average = 0.0
         release_date = ""
    }
    init(_id:Int,tit:String,pop:Double,ov:String,poster:String,vote:Double,date:String){
        
        id = _id
        title = tit
        popularity = pop
        overview = ov
        poster_path = poster
        vote_average = vote
        release_date = date
    }
    
}
