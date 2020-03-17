//
//  TableViewController.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var networkActivity : UIActivityIndicatorView?
    var reviewsArr: [Reviews] = []
    var movie:Movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let reviewsPresenter = ReviewsPresnter(withReviewView: self)
        reviewsPresenter.getReview(id: movie.id)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviewsArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = reviewsArr[indexPath.row].author
        cell.detailTextLabel?.text = reviewsArr[indexPath.row].content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let v = self.storyboard?.instantiateViewController(withIdentifier: "revVC") as! ReviewViewController
        v.review = reviewsArr[indexPath.row];
        self.navigationController?.pushViewController(v, animated: true)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

extension TableViewController : IReviewView{
    

    func renderTableWithReviews(reviews: [Reviews]) {
        reviewsArr = reviews
        self.tableView.reloadData()
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
