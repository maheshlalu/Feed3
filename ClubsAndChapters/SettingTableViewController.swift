//
//  SettingTableViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 20/04/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        let ref = FIRDatabase.database().reference()
//        let usersReference = ref.child("USers")
//        let currentUser = Api.User.CURRENT_USER
//        let currentUserId = currentUser?.uid
//        let newUserReference = usersReference.child(currentUserId!)
//         newUserReference.setValue(["username": self.usernameTextField.text!])
//        
        
        
        
//        let currentUser = Api.User.CURRENT_USER
//        let uid = user?.uid
//       // let newUserReference = usersReference.child(uid!)
//        usersReference.childByAutoId().setValue(["username": "hi"])
        
        
//        
//        let ref = FIRDatabase.database().reference()
//        let usersReference = ref.child("users")
//        let uid = user?.uid
//        let newUserReference = usersReference.child(uid!)
//        newUserReference.setValue(["email": self.emailtextfield.text!])
//        



//        
//        
//        let commentsreference = Api.Comment.REF_COMMENTS
//        let newCommentId = commentsreference.childByAutoId().key
//        let newCommentReference = commentsreference.child(newCommentId)
//        
//        guard let currentUser = Api.User.CURRENT_USER else {
//            return
//        }
//        let currentUserId = currentUser.uid
//        newCommentReference.setValue(["uid": currentUserId, "commentText": commentTextField.text!],
//        
        

    navigationItem.title = "Edit Profile"
        fetchCurrentUser()
    }
    
    func fetchCurrentUser(){
    
          Api.User.observeCurrentUser { (user) in
//            
//            self.usernameTextField.text = user.username
              self.emailTextField.text = user.email
//            if let profileUrl = URL(string: user.profileImageUrl!){
//            self.profileImageview.sd_setImage(with: profileUrl)
//            }
        }
    }
    
    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
        
        
        
        
        
        
//        let ref = FIRDatabase.database().reference()
//        let usersReference = ref.child("USers")
//        let currentUser = Api.User.CURRENT_USER
//        let currentUserId = currentUser?.uid
//        let newUserReference = usersReference.child(currentUserId!)
//        newUserReference.setValue(["username": self.usernameTextField.text!, "profileImageUrl": "heheh"])
//        
//
        
        
//        
//        if let profileImg = self.profileImageview.image, let imageData = UIImageJPEGRepresentation(profileImg, 0.1){
//            AuthService.updateUserInfor(username: usernameTextField.text!, email: emailTextField.text!, imageData: imageData, onsuccess: {ProgressHUD.showSuccess("Success")}, onError: {(errorMessage) in ProgressHUD.showError(errorMessage)
//            })
//        }
    }
    
    @IBAction func logoutBtn_TouchUpInside(_ sender: Any) {
        
    }
    
    
    @IBAction func changeProfileBtn_TouchUpInside(_ sender: Any) {
        
        
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        present(pickerController, animated: true, completion: nil)
      }
}

//extension SettingTableViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
//    print("did finish picking media")
//        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
//        profileImageview.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}
