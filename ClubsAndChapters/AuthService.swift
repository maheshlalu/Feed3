//
//  AuthService.swift
//  ClubsAndChapters
//
//  Created by sri on 14/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    
    
   
    static func logout(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        do {
        try FIRAuth.auth()?.signOut()
            onSuccess()
        }
        catch let logoutError {
        
        onError(logoutError.localizedDescription)
        }
    }
    
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
    
        let ref = FIRDatabase.database().reference()
        let userReference = ref.child("users")
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["username": username, "username_lowercase": username.lowercased(), "email": email, "profileImageUrl": profileImageUrl])
        onSuccess()
    
    }
    
    
    static func updateUserInfor(username: String, email: String, imageData: Data, onsuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void){
        let uid = Api.User.CURRENT_USER?.uid
        let storageRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid!)
        
        storageRef.put(imageData, metadata: nil, completion: {(metadata, error) in

            if error != nil {
            return
            }
            let profileImageUrl = metadata?.downloadURL()?.absoluteString
            self.updateDatabase(profileImageUrl: profileImageUrl!, username: username, email: email, onSuccess: onsuccess, onError: onError)
        })
    }
    
    static func updateDatabase(profileImageUrl: String, username: String, email: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        let dict = ["username": username, "username_lowercase": username.lowercased(), "email": email, "profileImageUrl": profileImageUrl]
        Api.User.REF_CURRENT_USER?.updateChildValues(dict, withCompletionBlock: { (error, ref) in
            if error != nil {
                onError(error!.localizedDescription)
            } else {
                onSuccess()
            }
            
        })
    }


}
