//
//  LoginViewController.swift
//  TripXperience
//
//  Created by Sergio Llopis on 4/15/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func onLogin(_ sender: Any) {
        
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            // START headless_email_auth
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                // START_EXCLUDE
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // END_EXCLUDE
            }
            // END headless_email_auth
        } else {
            print("Error: email/password can't be empty")
        }
    }
}


