//
//  myEventPostApi.swift
//  ClubsAndChapters
//
//  Created by sri on 05/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import Foundation
import Firebase

class myEventPostApi{
    
    var REF_MYEVENTPOSTS = FIRDatabase.database().reference().child("myeventposts")
    var REF_MYNEWSPOSTS = FIRDatabase.database().reference().child("mynewsposts")
    
}
