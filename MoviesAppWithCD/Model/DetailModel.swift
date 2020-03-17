//
//  DetailModel.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class DetailModel{
    
    
    var presenter:IDetailPresenter
    init(pres:IDetailPresenter) {
        self.presenter = pres
    }
    
    func getVideos(id:Int){
        var arrStr = [[String:AnyObject]]()
        var arrVideos = [Videos]()
        var idStr = String(id)
        let url = URL(string:"https://api.themoviedb.org/3/movie/" + idStr + "/videos?api_key=373ef7dcc6a3176a6f18a8a04f036f7a")!
        Alamofire.request(url).responseJSON{(responseData) -> Void in
            if((responseData.result.value) != nil){
                
                //                print(responseData.result.value!)
                let swiftifyJsonVar = JSON(responseData.result.value!)
                if let result = swiftifyJsonVar["results"].arrayObject{
                    arrStr = result as! [[String:AnyObject]]
                    for item in arrStr{
                        var video:Videos?
                        let key = item["key"] as! String
                        
                        // let duration = item["d"] as! Double
                        video = Videos(_key: key)
                        arrVideos.append(video!);
                    }
                    self.presenter.onSuccess(videos: arrVideos)
                }
            }
        }
        
    }
}
