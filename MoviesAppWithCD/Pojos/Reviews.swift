//
//  Reviews.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
class Reviews{
    var author:String
    var content:String
    init() {
        author = ""
        content = ""
    }
    init(_author:String,_content:String) {
        author = _author
        content = _content
    }
}
