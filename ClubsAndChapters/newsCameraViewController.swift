//
//  newsCameraViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 30/05/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class newsCameraViewController: UIViewController {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsHeadline: UITextField!
    @IBOutlet weak var newsDetailDescription: UITextView!
    
    var selectedImage : UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectPoster))
        newsImage.addGestureRecognizer(tapGesture)
        newsImage.isUserInteractionEnabled = true

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    func handleSelectPoster(){
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
        
    }

    
    @IBAction func newsPost(_ sender: Any) {
        
        if let postImg = self.newsImage.image{
            print(postImg)
            ProgressHUD.show("Waiting...", interaction: false)

            LFFireBaseDataService.sharedInstance.postTheNewPostToFirebase(postImage: postImg, postDetails: ["newsHeadline": newsHeadline.text!, "newsDetailDescription": newsDetailDescription.text!], isNewsPost: true) { (isResponce) in
                
                ProgressHUD.showSuccess("success")
                self.newsHeadline.text = ""
                self.newsImage.image = UIImage(named: "newsplaceholder1")
                self.newsDetailDescription.text = ""
                
                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewControllerId")
                self.present(vc , animated: true, completion: nil)


            }
        }
        
       
        
        
        
       /* if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1){
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
        }*/

        
    }

    func sendDataToDatabase(photoUrl: String){
        
        let ref = FIRDatabase.database().reference()
        let postsreference = ref.child("news")
        let newpostId = postsreference.childByAutoId().key
        let newPostReference = postsreference.child(newpostId)
        
        
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "photoUrl": photoUrl, "newsHeadline": newsHeadline.text!, "newsDetailDescription": newsDetailDescription.text!], withCompletionBlock: {
            (error, ref) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            let myPostRef = Api.MyEventPosts.REF_MYNEWSPOSTS.child(currentUserId).child(newpostId)
            
            myPostRef.setValue(true, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                
            })
            
            ProgressHUD.showSuccess("success")
            self.newsHeadline.text = ""
            self.newsImage.image = UIImage(named: "place-holder")
            self.newsDetailDescription.text = ""
            
            
          
        })
        
    }

    
  }

extension newsCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        print("finish picking media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = image
            newsImage.image = image
            
        }
        dismiss(animated: true, completion: nil)
    }
    
}




