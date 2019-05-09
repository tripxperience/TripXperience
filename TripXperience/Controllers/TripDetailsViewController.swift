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
import FirebaseStorage
import AlamofireImage

class TripDetailsViewController: UIViewController {
    
    var ref: DatabaseReference!
    var storageRef = Storage.storage().reference()
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var tripTitle: UINavigationItem!
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripDetails: UILabel!
    
   /* func start() {
        let db_name = "Jazz"
        
        getTripInfo(db_name: db_name) { (is_finished, message) in
            if is_finished {
                print(message)
            } else {
                print(message)
            }
        }
    }
    
    func getTripInfo(db_name : String, completion: @escaping (Bool, String) -> Void) {
        
        let request_done = false
        
        if request_done {
            completion(true, "Success!")
        } else {
            completion(false, "Failure..")
        }
    }*/
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
