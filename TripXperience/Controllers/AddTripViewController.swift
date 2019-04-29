//
//  AddTripViewController.swift
//  TripXperience
//
//  Created by Remberto on 4/22/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddTripViewController: UIViewController {
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func onAddTripButton(_ sender: Any) {
        let referenceTrip = self.ref.child("Users").child(userID!).child("Trips").child(titleField.text!)
        referenceTrip.child("title").setValue(titleField.text)
        referenceTrip.child("description").setValue(descriptionView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
}
