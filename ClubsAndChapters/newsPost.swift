//
//  newsPost.swift
//  ClubsAndChapters
//
//  Created by sri on 01/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation

class newsPost {

    var newsDetailDescription : String?
    var newsHeadline : String?
    var newsPhotoUrl : String?
    var uid : String?
    var id: String?
    
    
    
}

extension newsPost {

   static func transformNewsPost(dict : [String : Any],  key: String) -> newsPost {
        
        let newspost = newsPost()
        
        newspost.id = key
        newspost.newsDetailDescription = dict["newsDetailDescription"] as? String
        newspost.newsHeadline = dict["newsHeadline"] as? String
        newspost.newsPhotoUrl = dict["photoUrl"] as? String
        newspost.uid = dict["uid"] as? String
        
        return newspost
        
    }

}
