//
//  EventPostingViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 14/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class EventPostingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var eventImg: UIImageView!
    @IBOutlet var eventtitle: UITextField!
    @IBOutlet var eventVenue: UITextField!
    @IBOutlet var eventTime: UITextField!
    @IBOutlet var eventDate: UITextField!
    @IBOutlet var eventDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selecteventImage))
        eventImg.addGestureRecognizer(tapGesture)
        eventImg.isUserInteractionEnabled = true
    }
    
    func selecteventImage(){
        
        let action = UIAlertController(title: "select source", message: "select one", preferredStyle: UIAlertControllerStyle.actionSheet)
        let photoaction = UIAlertAction(title: "photo library", style: .default) { action -> Void in
           let photo = UIImagePickerController()
            photo.sourceType = .photoLibrary
            photo.allowsEditing = true
            photo.delegate = self
            self.present(photo, animated: true, completion: nil)
            
        }
        let cameraaction = UIAlertAction(title: "camera", style: UIAlertActionStyle.default) { action -> Void in
            let camera = UIImagePickerController()
            camera.sourceType = .camera
            camera.allowsEditing = true
            camera.delegate = self
            self.present(camera, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        action.addAction(photoaction)
        action.addAction(cameraaction)
        action.addAction(cancel)
        
        self.present(action, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        eventImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    
    @IBAction func postEventInternally(_ sender: Any) {
     
        if let postEventImage = eventImg.image {
            
            ProgressHUD.show("waiting...", interaction: false)
        
            LFFireBaseDataService.sharedInstance.postTheNewPostToFirebase(postImage: postEventImage, postDetails: ["eventTitle":eventtitle.text!,"eventDescription":eventDescription.text!,"eventTime":eventTime.text!,"eventVenue":eventVenue.text!,"eventDate":eventDate.text!], isNewsPost: false, completionBlock: { (isResponse) in
                
                ProgressHUD.show("success")
                self.eventImg.image = UIImage(named: "eventplaceholder")
                self.eventDescription.text = ""
                self.eventDate.text = ""
                self.eventVenue.text = ""
                self.eventTime.text = ""
                self.eventtitle.text = ""
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newpageViewController")
                self.present(vc, animated: true, completion: nil)
                
            })
        }
    }
}
