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
import FirebaseStorage
import AlamofireImage

class AddTripViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    var storageRef = Storage.storage().reference()
    let userID = Auth.auth().currentUser?.uid

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func onAddTripButton(_ sender: Any) {
//        let imageData = imageView.image?.pngData()
        
//        storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
//            if error != nil {
//                print(error as Any)
//            }
//            print(metadata as Any)
//        }
//        storageRef.putData(imageData)
        
//        let referenceTrip = self.ref.child("Users").child(userID!).child(titleField.text!)
//        referenceTrip.child("title").setValue(titleField.text)
//        referenceTrip.child("description").setValue(descriptionView.text)
        self.saveFIRData()
        HomeTripsViewController.is_adding_trip = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveFIRData() {
        self.uploadImage(self.imageView.image!) { url in
            self.saveImage(name: self.titleField.text!, profileURL: url!) { success in
                if success != nil {
                    print("Yeah Yes")
                }
                
            }
        }
    }
    
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
    
//    @IBAction func backButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        // Changing size of image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?) ->())) {
        let storageRef = Storage.storage().reference().child(titleField.text!)
        let imageData = imageView.image?.pngData()
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
    
    func saveImage(name: String, profileURL: URL, completion: @escaping ((_ url: URL?) ->())) {
        let dic = ["title": titleField.text!, "description": descriptionView.text!, "imageURL": profileURL.absoluteString] as [String: Any]
        self.ref.child("Users").child(userID!).child(titleField.text!).setValue(dic)
    }
}
