//
//  ProfileViewController.swift
//  TripXperience
//
//  Created by Sergio Llopis on 4/24/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignOut(_ sender: Any) {
        do
        {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(false, forKey: "userLoggedIn")
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }
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
