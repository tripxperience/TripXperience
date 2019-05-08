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

    @IBOutlet weak var tableView: UITableView!
    
    // Dictionary to store the Trips.          key[Title] ~> values[Any]
    var trips = [String:Any]()
    var tripsCopy = [String]()
    var numberTrips = 0
    var subArrayDictionary = [String]()
    
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
        
        // Fetching Trips from Database
        Database
            .database()
            .reference()
            .child("Users")
            .child(Auth.auth().currentUser!.uid)
            .queryOrderedByKey()
            .observeSingleEvent(of: .value, with: { snapshot in
                
                guard let dictionary = snapshot.value as? [String:Any] else {
                    print("Error")
                    return
                }
                
                // Storing the dictionary into trips
                self.trips = dictionary
                //                print(self.trips)
                
//                print(self.trips)
                
                
                
                
                let arrayDictionary = Array(self.trips.keys)
                
                print(arrayDictionary[0])
                
//                 var index1 = arrayDictionary[0]
                
//                var singleTripDictionary = Dictionary(self.trips[index1])
                
               // singleTripDictionary = Dictionary(singleTripDictionary)
                
                

                
                self.tableView.reloadData()
        
            })
    }
    
    // Number of actual cells being returned.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of trips each user has.
        return trips.count
    }
    
    // Declaring reusable cell. (NOT STATIC)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // ID is referencing the Storyboard.
        let cell = HomeTripTableView.dequeueReusableCell(withIdentifier: "TripCell")
            as! MyTripsCell
        
        for child in self.trips{
        
            if let trip = child.value as? [String:AnyObject]{

               // print(trip)
                let description = trip["description"]
                let title = trip["title"]
//                        let image = trip["image"]
//                        print(description)
                cell.titleTipField.text = title as? String
//                        print(title)
                cell.descriptionField.text = description as? String

//                        cell.tripImage.image = image as! UIImage
            }

        }
        return cell

    }

}
