//
//  ReviewViewController.swift
//  MoviesApp
//
//  Created by MacOSSierra on 3/16/20.
//  Copyright © 2020 huda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var content: UITextView!
    var review:Reviews = Reviews()
    override func viewDidLoad() {
        super.viewDidLoad()

        author.text = review.author
        content.text = review.content
        
        // Do any additional setup after loading the view.
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
