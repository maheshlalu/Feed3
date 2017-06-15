//
//  registerViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 02/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import FirebaseAuth
import FirebaseDatabase

class registerViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailIdLabel: UITextField!
    @IBOutlet var contactLabel: UITextField!
    @IBOutlet var registerImgView: UIImageView!
    
    @IBOutlet var registerBtnTapped: UIButton!
    var registereventpostsId = ""
//    
//    var eventpost : eventPost? {
//        didSet {
//        updateView()
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print("registerpostId: \(registereventpostsId)")
        updateView()
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        let tapGestureregisterBtn = UITapGestureRecognizer(target: self, action: #selector(self.registerBtn_TouchUpInside))
//        registerBtnTapped.addGestureRecognizer(tapGestureregisterBtn)
//        registerBtnTapped.isUserInteractionEnabled = true
//        
//        
//    }
    
    func updateView() {
    
        if let currentUser = FIRAuth.auth()?.currentUser {
            
            Api.User.REF_USERS.child(currentUser.uid).child("RegisteredDetails").child(registereventpostsId).observeSingleEvent(of: .value, with: { snapshot in
                if let _ = snapshot.value as? NSNull{
                    self.registerImgView.image = UIImage(named: "dislike")
                }  else {
                    self.registerImgView.image = UIImage(named: "like")
                }
            })
            
        }
        
    }
    

    
       func registerBtn_TouchUpInside() {
    
        if let currentUser = FIRAuth.auth()?.currentUser {
            
            Api.User.REF_USERS.child(currentUser.uid).child("RegisteredDetails").child(registereventpostsId).observeSingleEvent(of: .value, with: { snapshot in
                
                if let _ = snapshot.value as? NSNull{
                    
                    Api.User.REF_USERS.child(currentUser.uid).child("RegisteredDetails").child(self.registereventpostsId).setValue(true)
                    self.registerImgView.image = UIImage(named: "like")

                } else {
                    
                Api.User.REF_USERS.child(currentUser.uid).child("RegisteredDetails").child(self.registereventpostsId).removeValue()
                    self.registerImgView.image = UIImage(named: "dislike")
                    
                }
            })
            
        }
        
    }


    @IBAction func registerBtn(_ sender: Any) {
        
        //
        //        if !MFMailComposeViewController.canSendMail() {
        //            print("Mail services are not available")
        //            return
        //        }
        //
        
        if nameTextField.text == "" || emailIdLabel.text == "" || contactLabel.text == "" {
            
            let alert = UIAlertController(title: "oops!", message: "enter credits", preferredStyle: .alert)
            let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(defaultaction)
            self.present(alert, animated: true, completion: nil)
            
        }else {
        
            // sendEmail()
          registerBtn_TouchUpInside()
            
            let alert = UIAlertController(title: "suscess", message: "you have been registered", preferredStyle: .alert)
            let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(defaultaction)
            self.present(alert, animated: true, completion: nil)
        
        
            let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewControllerId")
            self.present(vc , animated: true, completion: nil)
        
        
        }
    
        
    }
    
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        
        
        composeVC.setToRecipients([emailIdLabel.text!])
        
        let subject = titleLabel.text
        
        composeVC.setSubject("\(subject)")
        
        let message = "\(nameTextField) \n \(emailIdLabel) \n \(contactLabel)"
        
        composeVC.setMessageBody("\(message)", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }

    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    
}
