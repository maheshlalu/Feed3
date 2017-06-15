//
//  NewHeaderViewCollectionReusableView.swift
//  ClubsAndChapters
//
//  Created by sri on 04/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit


class NewHeaderViewCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet var profileimage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var segmentView: UISegmentedControl!
    @IBOutlet var editBtn: UIButton!
    
        var user: User? {
        didSet {
            updateview()
        }
    }
    
    func updateview() {
              self.nameLabel.text = user?.email
        
        if user?.id == Api.User.CURRENT_USER?.uid {
            editBtn.isEnabled = true
            editBtn.setTitle("EditButton", for: .normal)
//            editBtn.addTarget(self, action: #selector(self.goToSettingVC), for: UIControlEvents.touchUpInside)
        }else{
            editBtn.setTitle("", for: .normal)
            editBtn.isEnabled = false
            editBtn.alpha = 0.0
        }

    }
    
    
    
    
    
   
    
}
