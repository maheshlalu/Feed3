//
//  NewsPostingViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 14/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class NewsPostingViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var newsHeadline: UITextField!
    @IBOutlet var newsDescription: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectNewsImage))
        newsImage.addGestureRecognizer(tapGesture)
        newsImage.isUserInteractionEnabled = true
        
    }
    
    func selectNewsImage(){
        
        let action = UIAlertController(title: "select source type", message: "select one", preferredStyle: UIAlertControllerStyle.actionSheet)
        let photoaction = UIAlertAction(title: "photo Library", style: UIAlertActionStyle.default) { action -> Void in
            
            let photo = UIImagePickerController()
            photo.sourceType = UIImagePickerControllerSourceType.photoLibrary
            photo.allowsEditing = true
            photo.delegate = self
            
            self.present(photo, animated: true, completion: nil)
            
        }
        let cameraAction = UIAlertAction(title: "camera Actio0n", style: UIAlertActionStyle.default) { action -> Void in
            
            let camera = UIImagePickerController()
            camera.sourceType = .camera
            camera.allowsEditing = true
            camera.delegate = self
            
            self.present(camera, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        action.addAction(photoaction)
        action.addAction(cameraAction)
        action.addAction(cancel)
        
        self.present(action, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        newsImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
    }
    @IBAction func Postbtn(_ sender: Any) {
        
        if let postImg = newsImage.image {
            
            ProgressHUD.show("Waiting...", interaction: false)
            
            LFFireBaseDataService.sharedInstance.postTheNewPostToFirebase(postImage: postImg, postDetails: ["NewsHeadline" : newsHeadline.text!, "NewsDescription" : newsDescription.text!], isNewsPost: true, completionBlock: { (isResponse) in
                
                ProgressHUD.showSuccess("success")
                ProgressHUD.dismiss()
                self.newsHeadline.text = ""
                self.newsImage.image = UIImage(named: "newsplaceholder1")
                self.newsDescription.text = ""
                
//                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newpageViewController")
//                self.present(vc , animated: true, completion: nil)
                 self.dismiss(animated: true, completion: nil)
                
            })
        }
    }
}
