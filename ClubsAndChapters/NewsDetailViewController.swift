//
//  NewsDetailViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 05/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewsDetailViewController: UIViewController {
    
    var newspostsId = ""
    
    var newspost = newsPost()
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("newspostId: \(newspostsId)")
      //  loadNewsPost()

    }

    func loadEventPost() {
        
        FIRDatabase.database().reference().child("news").child(newspostsId).observe(.childAdded){(snapshot: FIRDataSnapshot) in
            print(snapshot.value)
            
        }
        
    }

    
    
//    func loadNewsPost() {
//    
//        Api.Post.observeNewsPost(withId: newspostsId) { (newspost) in
//            
//            guard let newsPostUid = newspost.uid else {
//                return
//            }
//            self.fetchUser(uid: newsPostUid, completed: {
//                self.newspost = newspost
//                
//            })
//        }
//    }
//    
//    func fetchUser(uid: String, completed: @escaping () -> Void ){
//        
//        Api.User.observeUser(withId: uid) { user in
//            self.user = user
//            completed()
//        }
//        
//    }
//    
}
