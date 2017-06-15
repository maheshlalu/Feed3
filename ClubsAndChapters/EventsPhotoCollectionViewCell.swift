//
//  EventsPhotoCollectionViewCell.swift
//  ClubsAndChapters
//
//  Created by sri on 04/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import SDWebImage

class EventsPhotoCollectionViewCell: UICollectionViewCell {
    
       @IBOutlet var eventPhoto: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    var eventpost : eventPost? {
        didSet {
            updateView()
        }
    }
    func updateView() {
        
        titleLabel.text = eventpost?.title
        
        if  let photoUrlString = eventpost?.photoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            eventPhoto.sd_setImage(with: photoUrl)
            
        }
    }
}
