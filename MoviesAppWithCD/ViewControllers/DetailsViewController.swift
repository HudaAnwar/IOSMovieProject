//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 huda. All rights reserved.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper
import Cosmos
import CoreData
class DetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var networkActivity : UIActivityIndicatorView?
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var rating: CosmosView!
    var videosArr: [Videos] = []
    var movie:Movie = Movie()
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var movTitle: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var favBtn: UIButton!
    var movIndex:Int = 0
    var movieArr:[NSManagedObject] = []
    var favCheck:Bool = false
    @IBAction func favorites(_ sender: Any) {
        if(favCheck == true){
            
            let appDelegate : AppDelegate = UIApplication.shared.delegate as!
            AppDelegate
           
            
            // 2
            let manageContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
            
            do{
                
                movieArr=try manageContext.fetch(fetchRequest)
            }catch let error{
                
                print(error)
            }
            for i in 0..<movieArr.count{
                if(movie.id == movieArr[i].value(forKey: "id") as! Int ){
                    
                    movIndex = i
                   
                    break;
                }
                
            }
            
          
            
            // 2
            
            manageContext.delete(movieArr[movIndex])
            print("deleted")
            
            movieArr.remove(at:movIndex)
            // 3
          
            
            do{
                
                try manageContext.save()
            }catch let error{
                
                print(error)
            }
              favCheck = false
             favBtn.setTitle("Add to favorites", for: .normal)
            
        }else{
        
        // 1
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 3
        let entity = NSEntityDescription.entity(forEntityName:"Favorites", in: manageContext)
       
        // 4
        let movieCD = NSManagedObject(entity: entity!, insertInto: manageContext)
        
        movieCD.setValue(movie.id, forKey: "id")
        movieCD.setValue(movie.overview, forKey: "overview")
        var img = posterImg.image?.toData as! NSData
        movieCD.setValue(img, forKey: "poster")
        movieCD.setValue(movie.release_date, forKey: "release_date")
        movieCD.setValue(movie.title, forKey: "title")
        movieCD.setValue(movie.vote_average, forKey: "vote_average")
            do{
            // 5
             try manageContext.save()
            
            }catch let error{
            
            print(error)
            }
              favCheck = true
              favBtn.setTitle("Remove from favorites", for: .normal)
        
        }
    }
    @IBAction func reviews(_ sender: Any) {
        
        let v = self.storyboard?.instantiateViewController(withIdentifier: "reviewsVC") as! TableViewController
        v.movie = movie
        self.navigationController?.pushViewController(v, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        do{
            
            movieArr=try manageContext.fetch(fetchRequest)
        }catch let error{
            
            print(error)
        }
        for i in 0..<movieArr.count{
            if(movie.id == movieArr[i].value(forKey: "id") as! Int ){
                favBtn.setTitle("Remove from favorites", for: .normal)
                movIndex = i
                favCheck = true
                break;
            }
            else{
                favBtn.setTitle("Add to favorites", for: .normal)
                favCheck = false
            }
        }
        let url = "https://image.tmdb.org/t/p/w185/" + movie.poster_path
        print(url)
        let img = "placeholder.png"
        posterImg.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: img))
        date.text = movie.release_date
        desc.text = movie.overview
        rating.rating = Double(movie.vote_average/2.0)
        
        movTitle.text = movie.title
        let detailPresenter = DetailsPresnter(withDetailView: self)
        detailPresenter.getVideos(id: movie.id)
        
        myTable.dataSource = self
        myTable.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArr.count
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let playerView = cell.contentView.viewWithTag(1) as? YTPlayerView
        playerView?.load(withVideoId: videosArr[indexPath.row].key)
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImage{
    var toData:Data?{
        return pngData()
    }
}
class ImageDAO {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    private func saveContext() {
        try! container.viewContext.save()
    }
}


extension DetailsViewController : IDetailView{
    
   
    func renderDetailWithVideos(videos: [Videos]) {
          videosArr = videos
        self.myTable.reloadData();
        
    }
//        self.collectionView.reloadData()
    
    
    func showLoading() {
        
        print("Start Loading....")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        networkActivity = UIActivityIndicatorView(style: .gray)
        networkActivity?.center = self.view.center
        networkActivity?.startAnimating()
        self.view.addSubview(networkActivity!)
        
        
    }
    
    func hideLoading() {
        
        print("Stop Loading.....")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        networkActivity?.stopAnimating()
    }
    
    func showErrorMessage(errorMessage: String) {
        
        print(errorMessage)
        
    }
}
