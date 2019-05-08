//
//  HomeTripsViewController.swift
//  TripXperience
//
//  Created by Remberto on 4/29/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeTripsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    // View Outlet
    @IBOutlet weak var HomeTripTableView: UITableView!
    
    // Database Reference
     var ref: DatabaseReference!
    
    // Getting the current user ID to fetch THEIR trips.
    let userID = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database Reference to fetch Trips
        ref = Database.database().reference()
     
        // Connecting the View.
        HomeTripTableView.delegate = self
        HomeTripTableView.dataSource = self

    }
    
    // Number of actual cells being returned.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of trips each user has.
        return 5;
    }
    
    // Declaring reusable cell. (NOT STATIC)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // ID is referencing the Storyboard.
        let cell = HomeTripTableView.dequeueReusableCell(withIdentifier: "TripCell")
            as! MyTripsCell
		
        
        return cell
        
    }

}
