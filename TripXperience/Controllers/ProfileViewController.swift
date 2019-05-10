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
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet var emailLabel: UILabel!
	@IBOutlet var profileImage: UIImageView!

    var pictureRef: DatabaseReference!
    
    var profileUsers = [TripModel]()

    var ref: DatabaseReference!
    var storageRef = Storage.storage().reference()
    let userID = Auth.auth().currentUser?.uid
    
   
	
	override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let userEmail = Auth.auth().currentUser?.email

        emailLabel.text = userEmail
        
        
        pictureRef = Database.database().reference().child("Pictures").child(userID!)
        
        
        
        pictureRef.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.profileUsers.removeAll()
                print("firebase call")
                //iterating through all the values
                for Profiles in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let profileObject = Profiles.value as? [String: AnyObject]
                    let userProfile = profileObject?["profileURL"]
                    
                    
                    let profileURL = userProfile as! String?
                    
                    let url = URL(string: userProfile as! String!)
                    
                    self.profileImage.af_setImage(withURL: url!)
        
            
                    
                    
                }
            }
        })
    
    }
    
    func saveFIRData() {
        self.uploadImage(self.profileImage.image!) { url in
            self.saveImage(profileURL: url!) { success in
                if success != nil {
                    print("Yeah Yes")
                }
                
            }
        }
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

    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        // Changing size of image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileImage.image = scaledImage
        
         self.saveFIRData()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?) ->())) {
        let storageRef = Storage.storage().reference().child(userID!)
        let imageData = profileImage.image?.pngData()
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/png"
        storageRef.putData(imageData!, metadata: metaData) { (metaData, error) in
            if error == nil {
                print("Success")
                storageRef.downloadURL(completion: { (url , error) in
                    completion(url)
                })
            }
            else {
                print("Error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileURL: URL, completion: @escaping ((_ url: URL?) ->())) {
        let dic = ["profileURL": profileURL.absoluteString] as [String: Any]
//        print(dic)
        self.ref.child("Pictures").child(userID!).child("userProfile").setValue(dic)
    }
}
