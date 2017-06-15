//
//  ForgetPasswordViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 12/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import  FirebaseAuth

class ForgetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func ForgetPasswordBtn(_ sender: Any) {
        
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            
            if error == nil {
                
                let alert = UIAlertController(title: "Success", message: "Email has been sent to  your registered EmailId", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                    
                    self.forgetpassword()
                    
                })
            
            }else if self.emailTextField.text == "" {
                
                let alert = UIAlertController(title: "oops", message: "Please enter credientials", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            
            }else {
            
                let alert = UIAlertController(title: "oops", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            
            }
            
        }
        
    }
    
    func forgetpassword() {
    
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
}
