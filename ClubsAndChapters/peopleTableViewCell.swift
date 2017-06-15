//
//  peopleTableViewCell.swift
//  ClubsAndChapters
//
//  Created by sri on 19/03/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
protocol PeopleTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}

class peopleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: PeopleTableViewCellDelegate?
    var users : [User] = []
    var user: User? {
    
        didSet {
        updateView()
        }
    
    }
    
    func updateView(){
        nameLabel.text = user?.email
    }
    
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.nameLabel_TouchUpInside))
        nameLabel.addGestureRecognizer(tapGesture)
        nameLabel.isUserInteractionEnabled = true
        
        
    }
    
    func nameLabel_TouchUpInside(){
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
        }
        
    }

}
