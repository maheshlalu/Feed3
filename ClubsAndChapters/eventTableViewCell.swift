//
//  eventTableViewCell.swift
//  ClubsAndChapters
//
//  Created by sri on 31/05/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol eventTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
    func goToEventDetailVC(eventpostId: String)
    func goToRegisterVC(eventpostId: String)

}


class eventTableViewCell: UITableViewCell {
    
    var delegate: eventTableViewCellDelegate?
    
    @IBOutlet var clubNameLabel: UILabel!
    @IBOutlet var eventPostImgView: UIImageView!
    @IBOutlet var intrestedImgView: UIImageView!
    @IBOutlet var intrestedLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var registerLabel: UIButton!
    
    @IBOutlet var getInfoBtn: UIButton!
    
    var eventpost: eventPost? {
    
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
    
      
        titleLabel.text = eventpost?.title
        intrestedLabel.text = "10"
        
        if  let photoUrlString = eventpost?.photoUrl {
            
            let photoUrl = URL(string: photoUrlString)
            eventPostImgView.sd_setImage(with: photoUrl)
            
        }
        
        //done this
        let tapGestureGetInfo = UITapGestureRecognizer(target: self, action: #selector(self.GetInfo_TouchUpInside))
        getInfoBtn.addGestureRecognizer(tapGestureGetInfo)
        getInfoBtn.isUserInteractionEnabled = true
        
        let tapGestureIntrestedLabel = UITapGestureRecognizer(target: self, action: #selector(self.IntrestedLabel_TouchUpInside))
        registerLabel.addGestureRecognizer(tapGestureIntrestedLabel)
        registerLabel.isUserInteractionEnabled = true


        
        
        setupUserInfo()
    }
    
    //done this
    func GetInfo_TouchUpInside() {
    
        if let id = eventpost?.id {
            delegate?.goToEventDetailVC(eventpostId: id)
            print("eventtapped")
            
        }
    }
    
    func IntrestedLabel_TouchUpInside() {
    
        if let id = eventpost?.id {
            delegate?.goToRegisterVC(eventpostId: id)
            print("intrestedtapped")
            
        }

    
    }
    
    
    func setupUserInfo() {
    
              clubNameLabel.text = user?.email
        
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureNamelabel = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        clubNameLabel.addGestureRecognizer(tapGestureNamelabel)
        clubNameLabel.isUserInteractionEnabled = true
        
               
        
    }
    
    func nameLabel_TouchUpInside(){
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
            print("tapped")

        }
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
