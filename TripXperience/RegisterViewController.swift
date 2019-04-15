//
//  RegisterViewController.swift
//  TripXperience
//
//  Created by Sergio Llopis on 4/15/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //FirebaseApp.configure()
    }
    
    @IBAction func onRegister(_ sender: Any) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    // Path to redirect user to Login Page
                    let Loginvc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                    
                    // Alert Message
                    let alertController = UIAlertController(title: "Success", message: "You have successfully signed up", preferredStyle: .alert)
                    
                    // Adding "Confirm button" to Alert Message
                    alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { _ in
                        
                        // Present Login VC
                        self.present(Loginvc!, animated: true, completion: nil)
                        
                    }))
                    
                    //Present UI Alert Message
                    self.present(alertController, animated: true, completion: nil)
                    
                   
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
