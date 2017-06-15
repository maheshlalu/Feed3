//
//  LFFireBaseDataService.swift
//  Lefoodie
//
//  Created by apple on 23/02/17.
//  Copyright © 2017 ongo. All rights reserved.
//https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2

import UIKit
import Firebase
import FirebaseDatabase

private var firebaseInstance:LFFireBaseDataService! = LFFireBaseDataService()

class LFFireBaseDataService: NSObject {

    let firebaseRef = FIRDatabase.database().reference()
    //MARK: Post Storage Reference
    
    let postStorageRef = FIRStorage.storage().reference(forURL: "gs://vitents-9b0c3.appspot.com").child("posts")

    //MARK: News Post Reference
    
    let newsPostReference = FIRDatabase.database().reference().child("news")
    
    //MARK:Users
    
    let currentUserId = FIRAuth.auth()?.currentUser?.uid
    
    //MARK:CurrentUIserId
    
    
    
    class var sharedInstance : LFFireBaseDataService {
        return firebaseInstance
    }
    
    override init() {
    }
    
    
    func postTheNewPostToFirebase(postImage:UIImage,postDetails:NSMutableDictionary,isNewsPost:Bool,completionBlock:@escaping (Bool)->Void){
      
        if isNewsPost {
            //news post
            self.imageUploadToFirebase(postImage: postImage, completionPostUpload: { (urlStr) in
                print(urlStr)
                postDetails["photoUrl"] = urlStr
                postDetails["uid"] = self.firebaseRef.childByAutoId().key
                
                self.newsPostReference.child(self.currentUserId!).child(self.firebaseRef.childByAutoId().key).setValue(postDetails, withCompletionBlock: { (error, refer) in
                    completionBlock(true)

                })

                //"photoUrl": photoUrl,
                //"uid": currentUserId,
            })
        }else{
            
            self.imageUploadToFirebase(postImage: postImage, completionPostUpload: { (urlStr) in
                print(urlStr)
                postDetails["photoUrl"] = urlStr
                postDetails["uid"] = self.firebaseRef.childByAutoId().key
                
                self.firebaseRef.child("events").child(self.currentUserId!).child(self.firebaseRef.childByAutoId().key).setValue(postDetails, withCompletionBlock: { (error, refer) in
                    completionBlock(true)
                    
                })
                
                //"photoUrl": photoUrl,
                //"uid": currentUserId,
            })
            
        }
    }
    
    func imageUploadToFirebase(postImage:UIImage,completionPostUpload:@escaping (_ photoUrl:String)->Void){
        
        //Auto Genarated key
        postStorageRef.child(firebaseRef.childByAutoId().key).put(UIImageJPEGRepresentation(postImage, 0.1)!, metadata: nil, completion: { (metadata, error) in
            if error != nil{
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            let photoUrl = metadata?.downloadURL()?.absoluteString
            completionPostUpload(photoUrl!)
        })
    }

    
}




