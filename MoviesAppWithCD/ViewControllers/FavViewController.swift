//
//  FavViewController.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import UIKit
import CoreData
class FavViewController: UITableViewController {
    
//    func addMovieDelegate(mov: NSManagedObject) {
//        movieArr.append(mov)
//        self.tableView.reloadData()
//    }
//
    var movieArr:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 3
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        
        do{
            
            movieArr=try manageContext.fetch(fetchRequest)
        }catch let error{
            
            print(error)
        }
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let titleLabel = cell.contentView.viewWithTag(2) as? UILabel

        titleLabel?.text=movieArr[indexPath.row].value(forKey: "title") as! String
        let imgView = cell.contentView.viewWithTag(1) as? UIImageView
        
        var img = movieArr[indexPath.row].value(forKey: "poster") as! NSData
        imgView?.image = UIImage(data: img as Data)!
        return cell
        
        // Configure the cell...

       
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let appDelegate : AppDelegate = UIApplication.shared.delegate as!
            AppDelegate
            
            // 2
            let manageContext = appDelegate.persistentContainer.viewContext
            manageContext.delete(movieArr[indexPath.row])
            print("deleted")
            
            movieArr.remove(at:indexPath.row)
            // 3
            
            
            do{
                
                try manageContext.save()
            }catch let error{
                
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
