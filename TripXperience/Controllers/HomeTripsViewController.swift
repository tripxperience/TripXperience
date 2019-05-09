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

    // Dictionary to store the Trips.          key[Title] ~> values[Any]
    var trips = [String:Any]()
    var userTrips = [TripModel]()
    
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
        
        getTrips()
    }
    
    
    
    func getTrips() {
        // Fetching the data
        ref = Database.database().reference().child("Users").child(userID!)
        //observing the data changes
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.userTrips.removeAll()
                print("firebase call")
                //iterating through all the values
                for Trips in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let tripObject = Trips.value as? [String: AnyObject]
                    let tripTitle  = tripObject?["title"]
                    let tripDescription  = tripObject?["description"]
                    print(tripTitle)
                    print(tripDescription)
                    let trip = TripModel(title: tripTitle  as! String?, description: tripDescription as! String?)
                    
                    self.userTrips.append(trip)
                }
                //reloading the tableview
                self.HomeTripTableView.reloadData()
            }
        })
    
    }
    
    // Number of actual cells being returned.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of trips each user has.
        return userTrips.count
    }
    
    // Declaring reusable cell. (NOT STATIC)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // ID is referencing the Storyboard.
        let cell = HomeTripTableView.dequeueReusableCell(withIdentifier: "TripCell")
            as! MyTripsCell
    
        
        let trip : TripModel
        trip = userTrips[indexPath.row]
        
        
        cell.titleTipField.text = trip.title
        cell.descriptionField.text = trip.description
        
        return cell
        
    }

}
