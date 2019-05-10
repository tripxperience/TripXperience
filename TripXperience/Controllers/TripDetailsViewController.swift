//
//  TripDetailsViewController.swift
//  TripXperience
//
//  Created by Jashmae Baculpo on 5/8/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TripDetailsViewController: UIViewController {

    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var userTrips = [TripModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tripTitle = userTrips[0].title
        let tripDescription = userTrips[0].description
        let tripImage = userTrips[0].image!
        
        
        let url = URL(string: tripImage)
    
        
        self.titleBar.title = tripTitle
        self.detailLabel.text = tripDescription
        self.image.af_setImage(withURL: url!)
        self.detailLabel.sizeToFit()
    }
    
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     @IBAction func backButton(_ sender: Any) {
     dismiss(animated: true, completion: nil)
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
