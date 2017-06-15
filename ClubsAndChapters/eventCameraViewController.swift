//
//  eventCameraViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 30/05/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class eventCameraViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var TimeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var VenueTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var invitebutton: UIButton!
    
    var selectedImage : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectPoster))
        poster.addGestureRecognizer(tapGesture)
        poster.isUserInteractionEnabled = true
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleSelectPoster(){
    
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
        
    }
    

    @IBAction func inviteButton_touchUpInside(_ sender: Any) {
    
        ProgressHUD.show("Waiting...", interaction: false)

                if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1){
            //   let ratio = ph
            let photoIdString = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference(forURL: "gs://vitents-9b0c3.appspot.com").child("posts").child(photoIdString)
            storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                
                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewControllerId")
                self.present(vc , animated: true, completion: nil)
                
                let photoUrl = metadata?.downloadURL()?.absoluteString
                self.sendDataToDatabase(photoUrl: photoUrl!)
                
            })
        }
    
    }
    
    func sendDataToDatabase(photoUrl: String){
        
        let ref = FIRDatabase.database().reference()
        let postsreference = ref.child("events")
        let newpostId = postsreference.childByAutoId().key
        let newPostReference = postsreference.child(newpostId)
        
        
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "photoUrl": photoUrl, "title": titleTextField.text!, "time": TimeTextField.text!, "date": dateTextField.text!, "venue": VenueTextField.text!, "eventDescription": eventDescriptionTextView.text!], withCompletionBlock: {
            (error, ref) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            let myEventPostRef = Api.MyEventPosts.REF_MYEVENTPOSTS.child(currentUserId).child(newpostId)
            
            myEventPostRef.setValue(true, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
            })
            
            ProgressHUD.showSuccess("success")
            self.titleTextField.text = ""
            self.poster.image = UIImage(named: "place-holder")
            self.dateTextField.text = ""
            self.TimeTextField.text = ""
            self.VenueTextField.text = ""
            self.eventDescriptionTextView.text = ""
            
         
        })
        
    }

    
}

extension eventCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        print("finish picking media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            poster.image = image
            
        }
        dismiss(animated: true, completion: nil)
    }
    
}


