//
//  UpdatePasswordViewController.swift
//  TripXperience
//
//  Created by Miguel Aceves on 4/29/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class UpdatePasswordViewController: UIViewController {
    
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var matchPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func onUpdatePassword(_ sender: Any) {
        
        // Check in old password
        if self.newPassword.text == "" || self.matchPassword.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else if newPassword.text != matchPassword.text  {
            
            let alertController = UIAlertController(title: "Error", message: "Your passwords do not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
            
            Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { (error) in
                if error == nil {
                    print("You have successfully updated your password")
                    let alertController = UIAlertController(title: "Success", message: "Password Successfully Updated", preferredStyle: .alert)
                    
                    let profile = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                    alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { _ in
                        
                        // Present Login VC
                        self.present(profile!, animated: true, completion: nil)
//                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    print("ERROR PASSWORD UPDATE WAS UNSUCCESSFUL")
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        //Update password
	}
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
