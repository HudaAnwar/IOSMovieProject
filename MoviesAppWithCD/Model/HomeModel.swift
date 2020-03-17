//
//  HomeModel.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/7/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
import Network
class HomeModel {
    
   
    
    var presenter:IHomePresenter
    init(pres:IHomePresenter) {
        self.presenter = pres
    }
    func getMovies(){
        var check:Bool = false
        var arrStr = [[String:AnyObject]]()
        var arrMovie = [Movie]()
        let monitor = NWPathMonitor()
        
       
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                check = false
                
                
                let url = URL(string:"http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=373ef7dcc6a3176a6f18a8a04f036f7a")!
                Alamofire.request(url).responseJSON{(responseData) -> Void in
                    if((responseData.result.value) != nil){
                        
                        //                print(responseData.result.value!)
                        let swiftifyJsonVar = JSON(responseData.result.value!)
                        if let result = swiftifyJsonVar["results"].arrayObject{
                            arrStr = result as! [[String:AnyObject]]
                            for item in arrStr{
                                var movie:Movie?
                                let id = item["id"] as! Int
                                let poster = item["poster_path"] as! String
                                print(poster)
                                let popularity = item["popularity"] as! Double
                                let overview = item["overview"] as! String
                                let title = item["title"] as! String
                                let rating = item["vote_average"] as! Double
                                let date = item["release_date"] as! String
                                // let duration = item["d"] as! Double
                                movie = Movie(_id: id,tit: title, pop: popularity, ov: overview, poster: poster, vote: rating, date: date/*,d:Double*/)
                                arrMovie.append(movie!);
                                
                            }
                            self.presenter.onSuccess(movies: arrMovie)
                        }
                    }
                }
                print("We're connected!")
            } else {
                check = true
                self.presenter.onFail(check:check)
                print("No connection.")
            }
            
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
       
        
    }
    
    
    
}
