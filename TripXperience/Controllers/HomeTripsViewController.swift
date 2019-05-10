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
    var trips = [[String:Any]]()
    var userTrips = [TripModel]()
    
    // View Outlet
    @IBOutlet weak var HomeTripTableView: UITableView!
    
    // Database Reference
     var ref: DatabaseReference!
    
    // Getting the current user ID to fetch THEIR trips.
    let userID = Auth.auth().currentUser?.uid
    
    let myRefreshController = UIRefreshControl()
    
    static var is_adding_trip = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Database Reference to fetch Trips
        ref = Database.database().reference()
     
        // Connecting the View.
        HomeTripTableView.delegate = self
        HomeTripTableView.dataSource = self
//        getTrips()
        myRefreshController.addTarget(self, action: #selector(getTrips), for: .valueChanged)
        getTrips()
        HomeTripTableView.refreshControl = myRefreshController
    }
    
    @objc func getTrips() {
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
                    print(tripTitle!)
                    let trip = TripModel(title: tripTitle  as! String?, description: tripDescription as! String?)
                    self.userTrips.append(trip)
                }
                //reloading the tableview
                
                self.HomeTripTableView.reloadData()
                self.myRefreshController.endRefreshing()
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
        
        return cell
        
    }
    
    
    @IBAction func onAddButton(_ sender: Any) {
        HomeTripsViewController.is_adding_trip = true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected movie
        if !HomeTripsViewController.is_adding_trip {
            print("Clicked on CELL")
            let cell = sender as! UITableViewCell
            let indexPath = HomeTripTableView.indexPath(for: cell)!
            let trip = userTrips[indexPath.row]
            
            // Pass the selected movie to the details view controller
            let detailsViewController = segue.destination as! TripDetailsViewController
            detailsViewController.userTrips = [trip]
            HomeTripTableView.deselectRow(at: indexPath, animated: true)
        } else {
            print("Clicked on ADD BUTTON")
        }
    }

}
