//
//  EventDetailViewController.swift
//  
//
//  Created by sri on 05/06/17.
//
//

import UIKit
import FirebaseDatabase

class EventDetailViewController: UIViewController {
    
    
    var eventpostsId = ""
    
    @IBOutlet var titleLabel: UILabel!
//    var eventpost = eventPost()
//    var user = User()
//

    override func viewDidLoad() {
        super.viewDidLoad()

        print("eventpostId: \(eventpostsId)")
       // loadEventPost()
    }
    
    func loadEventPost() {
    
       let info =  FIRDatabase.database().reference().child("events").child(eventpostsId).observe(.childAdded){(snapshot: FIRDataSnapshot) in
print(snapshot.value)
            
           // titleLabel.text = info.title
            
        
        }
    
    }
    
//
//    func loadEventPost() {
//    
//    Api.Post.observePost(withId: eventpostsId) { (eventpost) in
//        
//        guard let eventPostUid = eventpost.uid else {
//        return
//        }
//        self.fetchUser(uid: eventPostUid, completed: {
//        self.eventpost = eventpost
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
