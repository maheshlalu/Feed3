//
//  PostApi.swift
//  ClubsAndChapters
//
//  Created by sri on 13/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation
import Firebase

class PostApi{
//    var REF_POSTS = FIRDatabase.database().reference().child("posts")
//    var REF_NEWSPOSTS = FIRDatabase.database().reference().child("newsposts")
    var REF_POSTS = FIRDatabase.database().reference().child("events")
    var REF_NEWSPOSTS = FIRDatabase.database().reference().child("news")

    
    
    
//    func observePosts(completion: @escaping (Post) -> Void){
//        REF_POSTS.observe(.childAdded) {(snapshot: FIRDataSnapshot) in
//            if let dict = snapshot.value as? [String: Any]{
//                let newPost = Post.transformPostPhoto(dict: dict, key: snapshot.key)
//                completion(newPost)
//            }
//       }
//    }
    func observePosts(completion: @escaping (eventPost) -> Void){
        REF_POSTS.observe(.childAdded) {(snapshot: FIRDataSnapshot) in
            if let dict = snapshot.value as?[String : Any] {
            let neweventpost = eventPost.transformeventPost(dict: dict, key: snapshot.key)
                completion(neweventpost)
            }
        }
    }
    
    
        func observePost(withId id: String, completion: @escaping (eventPost) -> Void) {
            REF_POSTS.child(id).observeSingleEvent(of: FIRDataEventType.value, with: {
            snapshot in
                if let dict = snapshot.value as? [String: Any]{
                    let eventpost = eventPost.transformeventPost(dict: dict, key: snapshot.key)
                    completion(eventpost)
                }
            })
        }
    

    
    func observeNewsPosts(completion: @escaping (newsPost) -> Void){
        REF_NEWSPOSTS.observe(.childAdded) {(snapshot: FIRDataSnapshot) in
            if let dict = snapshot.value as? [String : Any]{
            let newnewspost = newsPost.transformNewsPost(dict: dict, key: snapshot.key)
                completion(newnewspost)
            }
        }
    }

    func observeNewsPost(withId id: String, completion: @escaping (newsPost) -> Void) {
        REF_NEWSPOSTS.child(id).observeSingleEvent(of: FIRDataEventType.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any]{
                let newspost = newsPost.transformNewsPost(dict: dict, key: snapshot.key)
                completion(newspost)
            }
        })
    }

    
}
