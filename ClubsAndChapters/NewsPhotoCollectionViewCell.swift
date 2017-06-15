//
//  NewsPhotoCollectionViewCell.swift
//  ClubsAndChapters
//
//  Created by sri on 04/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import SDWebImage

class NewsPhotoCollectionViewCell: UICollectionViewCell {
    
  //  @IBOutlet var newsLabel: UILabel!
    @IBOutlet var newsPhoto: UIImageView!
    var newspost : newsPost? {
        didSet {
            updateView()
        }
    }
    func updateView() {
   //     newsLabel.text = newspost?.newsHeadline
        if let photoUrlString = newspost?.newsPhotoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            newsPhoto.sd_setImage(with: photoUrl)
            
        }
    }
}
