//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/12/20.
//  Copyright © 2020 huda. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import BTNavigationDropdownMenu
class HomeViewController: UICollectionViewController {
    var networkActivity : UIActivityIndicatorView?
    var moviesArray: [Movie] = []
    var moviesCD: [NSManagedObject] = []
    var check = false
//    let items = ["Most Popular", "rating"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)
//        self.navigationItem.titleView = menuView
//
//        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
//            print("Did select item at index: \(indexPath)")
////            self.selectedCellLabel.text = items[indexPath]
//        }
        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false
       
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let homePresenter = HomePresnter(withHomeView: self)
        homePresenter.getMovies()

        // Do any additional setup after loading the view.
    }
   
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of items
        if moviesCD.count > 0{
            return moviesCD.count
        }
        
       
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesCache")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try manageContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                manageContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entry()) error : \(error) \(error.userInfo)")
        }
        
       
        return moviesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imgView = cell.contentView.viewWithTag(1) as? UIImageView
        if(!check){
        let url = "https://image.tmdb.org/t/p/w185/" + moviesArray[indexPath.row].poster_path
        print(url)
        let img = "placeholder.png" 
        // Configure the cell
            
        imgView?.sd_setImage(with: URL(string: url), placeholderImage:UIImage(named: img))
            
        // 1
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 3
        let entity = NSEntityDescription.entity(forEntityName:"MoviesCache", in: manageContext)
        
        // 4
        let movieCD = NSManagedObject(entity: entity!, insertInto: manageContext)
        
        movieCD.setValue(moviesArray[indexPath.row].id, forKey: "id")
        movieCD.setValue(moviesArray[indexPath.row].overview, forKey: "overview")
            var _img = imgView?.image?.toData as! NSData
            
        movieCD.setValue(_img, forKey: "poster")
        movieCD.setValue(moviesArray[indexPath.row].release_date, forKey: "release_date")
        movieCD.setValue(moviesArray[indexPath.row].title, forKey: "title")
        movieCD.setValue(moviesArray[indexPath.row].vote_average, forKey: "vote_average")
        do{
            // 5
            try manageContext.save()
            
        }catch let error{
            
            print(error)
        }
        }else{
            var img = moviesCD[indexPath.row].value(forKey: "poster") as! NSData
            imgView?.image = UIImage(data: img as Data)!
            
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
//        self.navigationController?.pushViewController(d, animated: true)
//        d.addProtocol=self
        let v = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        v.movie = moviesArray[indexPath.row];
        self.navigationController?.pushViewController(v, animated: true)
        
        
    }
    

}


extension HomeViewController : IHomeView{
    
    func renderHomeWithMovies(movies: [Movie]) {
        
        
        moviesArray = movies
        check = false
        self.collectionView.reloadData()
        
    }
    func renderHomeWithMoviesCD() {
        var movieArr:[NSManagedObject] = []
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 3
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MoviesCache")
        
        
        do{
            
            movieArr=try manageContext.fetch(fetchRequest)
        }catch let error{
            
            print(error)
        }
        moviesCD = movieArr
        check = true
        self.collectionView.reloadData()
        
    }
    
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
