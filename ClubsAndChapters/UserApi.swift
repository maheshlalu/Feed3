//
//  UserApi.swift
//  ClubsAndChapters
//
//  Created by sri on 13/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation
import Firebase

class UserApi {
    var REF_USERS = FIRDatabase.database().reference().child("users")
    
    func observeUser(withId uid: String, completion: @escaping (User) -> Void ){
    
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: {snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let user = User.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }

        })
        
    }
    
    func observeCurrentUser(completion: @escaping (User) -> Void){
        
        guard let currentUser = FIRAuth.auth()?.currentUser else{
            
            return 
        }
        
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: {snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let user = User.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
            
        })
        
    }

         
    func queryUsers(withText text: String, completion: @escaping(User) -> Void){
        REF_USERS.queryOrdered(byChild: "email").queryStarting(atValue: text).queryEnding(atValue: text+"\u{f8ff}").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: {
        snapshot in
            snapshot.children.forEach({(s) in
                let child = s as! FIRDataSnapshot
                if let dict = child.value as?[String: Any] {
                    let user = User.transformUser(dict: dict, key: child.key)
                completion(user)
                }
            })
            })
    }
    
    
    
    
    var CURRENT_USER: FIRUser? {
    
        if let currentUser = FIRAuth.auth()?.currentUser {
        
        return currentUser
        }
    
        return nil
    }
    
    
    
    var REF_CURRENT_USER: FIRDatabaseReference? {
    
        guard let currentUser = FIRAuth.auth()?.currentUser else{
        return nil
        }
     return REF_USERS.child(currentUser.uid)
        
    }
    
}

