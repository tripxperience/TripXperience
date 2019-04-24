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
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
    
            Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
        
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                        //Go to the HomeViewController if the login is sucessful
                        UserDefaults.standard.set(true, forKey: "userLoggedIn")
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        
                    } else {
                        
                         print("ERROR LOGIN UNSUCCESSFUL")
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
    }
}
    


