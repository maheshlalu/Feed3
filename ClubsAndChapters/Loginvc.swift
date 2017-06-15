//
//  Loginvc.swift
//  ClubsAndChapters
//
//  Created by sri on 11/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import Firebase

class Loginvc: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailtextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
        

    @IBAction func loginbutton(_ sender: Any) {
        
               view.endEditing(true)
        self.activityIndicator.startAnimating()

        
        FIRAuth.auth()?.signIn(withEmail: emailtextfield.text!, password: passwordtextfield.text!) { (user, error) in
            
            
            if error == nil{
                
                
                //storing email in database
                let ref = FIRDatabase.database().reference()
                let usersReference = ref.child("users")
                let uid = user?.uid
                let newUserReference = usersReference.child(uid!)
                newUserReference.setValue(["email": self.emailtextfield.text!])
                                 

        
                let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewControllerId")
                self.present(vc , animated: true, completion: nil)
                
                print("sucess login")
                self.activityIndicator.stopAnimating()

                
                
            }
            else if self.emailtextfield.text! == "" || self.passwordtextfield.text! == "" {
                
                let alert = UIAlertController(title: "oops!", message: "enter credits", preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()

            }
            else {
                
                let alert = UIAlertController(title: "oops!", message: (error?.localizedDescription), preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()

                
            }
            
        }
        
    }
    
    @IBAction func gobackbutton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
