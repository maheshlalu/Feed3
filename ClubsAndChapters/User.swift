//
//  User.swift
//  ClubsAndChapters
//
//  Created by sri on 13/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation
class User{

    var username: String?
    var email: String?
    var profileImageUrl: String?
    var id: String?

}

extension User{

    static func transformUser(dict: [String: Any], key: String) -> User {
        let user = User()
        user.username = dict["username"] as? String
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.id = key
        
        return user
    }
}
