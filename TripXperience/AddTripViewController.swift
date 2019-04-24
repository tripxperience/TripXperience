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
import FirebaseAuth

class AddTripViewController: UIViewController {
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    @IBAction func onAddTripButton(_ sender: Any) {
        let refereneTrip = self.ref.child("Users").child(userID!).child("Trips").child(titleField.text!)
        refereneTrip.child("title").setValue(titleField.text)
        refereneTrip.child("description").setValue(descriptionView.text)
        self.dismiss(animated: true, completion: nil)
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
