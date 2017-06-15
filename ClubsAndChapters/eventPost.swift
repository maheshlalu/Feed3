//
//  eventPost.swift
//  ClubsAndChapters
//
//  Created by sri on 31/05/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation

class eventPost {
    
    var date : String?
    var eventDescription : String?
    var photoUrl : String?
    var time : String?
    var title : String?
    var venue : String?
    var uid : String?
    var id: String?
    
    }

extension eventPost {

   static func transformeventPost(dict : [String : Any],  key: String) -> eventPost {
    
        let eventpost = eventPost()
    
        eventpost.id = key
        eventpost.date = dict["date"] as? String
        eventpost.eventDescription = dict["eventDescription"] as? String
        eventpost.photoUrl = dict["photoUrl"] as? String
        eventpost.time = dict["time"] as? String
        eventpost.title = dict["title"] as? String
        eventpost.venue = dict["venue"] as? String
        eventpost.uid = dict["uid"] as? String
        
        return eventpost

    
    }

}
