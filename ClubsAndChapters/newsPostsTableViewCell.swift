//
//  newsPostsTableViewCell.swift
//  ClubsAndChapters
//
//  Created by sri on 01/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage


protocol newsPostsTableViewCellDelegate {
    func newsToProfileUserVC(userId: String)
    func goToNewsDetailVC(newspostId: String)
}


class newsPostsTableViewCell: UITableViewCell {
    
    var delegate: newsPostsTableViewCellDelegate?

    @IBOutlet var newsPostImgView: UIImageView!
    @IBOutlet var clubNameLabel: UILabel!
    @IBOutlet var headlineLabel: UILabel!
    
    var newspost: newsPost? {
        
        didSet {
            updateView()
        }
    }
    
    var user: User? {
        
        didSet {
            
            setupUserInfo()
            
        }
    }

    
    func updateView() {
    
        
        headlineLabel.text = newspost?.newsHeadline
        
        if  let photoUrlString = newspost?.newsPhotoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            newsPostImgView.sd_setImage(with: photoUrl)
        }
        
        let tapGestureGetNewsInfo = UITapGestureRecognizer(target: self, action: #selector(self.GetNewsInfo_TouchUpInside))
        newsPostImgView.addGestureRecognizer(tapGestureGetNewsInfo)
        newsPostImgView.isUserInteractionEnabled = true

        
        setupUserInfo()
        
      }
    
    func GetNewsInfo_TouchUpInside() {
        
        if let id = newspost?.id {
            delegate?.goToNewsDetailVC(newspostId: id)
            print("newstapped")
            
        }
        
        
    }
    
    
    
    func setupUserInfo() {
        
        clubNameLabel.text = user?.email
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureNameLabel = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        clubNameLabel.addGestureRecognizer(tapGestureNameLabel)
        clubNameLabel.isUserInteractionEnabled = true
        
        
    }
    
    func nameLabel_TouchUpInside(){
        if let id = user?.id {
            delegate?.newsToProfileUserVC(userId: id)
        }
        
    }
    
      
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
