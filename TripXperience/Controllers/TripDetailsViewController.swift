//
//  TripDetailsViewController.swift
//  TripXperience
//
//  Created by Jashmae Baculpo on 5/8/19.
//  Copyright © 2019 tripxperience. All rights reserved.
//

import UIKit
import Firebase
class TripDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tripDetails: UILabel!
    @IBOutlet weak var uploadedImage: UIImageView!
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
     @IBAction func backButton(_ sender: Any) {
     dismiss(animated: true, completion: nil)
     }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
