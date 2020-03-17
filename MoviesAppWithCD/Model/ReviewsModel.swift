//
//  ReviewsModel.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ReviewsModel{
    
    
    var presenter:IReviewPresenter
    init(pres:IReviewPresenter) {
        self.presenter = pres
    }
    
    func getReviews(id:Int){
        var arrStr = [[String:AnyObject]]()
        var arrReviews = [Reviews]()
        var idStr = String(id)
        let url = URL(string:"https://api.themoviedb.org/3/movie/" + idStr + "/reviews?api_key=373ef7dcc6a3176a6f18a8a04f036f7a")!
        Alamofire.request(url).responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil){
                
                //                print(responseData.result.value!)
                let swiftifyJsonVar = JSON(responseData.result.value!)
                if let result = swiftifyJsonVar["results"].arrayObject{
                    arrStr = result as! [[String:AnyObject]]
                    for item in arrStr{
                        var review:Reviews?
                        let author = item["author"] as! String
                        let content = item["content"] as! String
                        // let duration = item["d"] as! Double
                        review = Reviews(_author: author, _content: content)
                        arrReviews.append(review!);
                    }
                    self.presenter.onSuccess(reviews: arrReviews)
                }
            }
        }
        
    }
}
