//
//  LoginViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 12/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginBtnOutlet: UIButton!
    @IBOutlet var selectCollegeBtnOutlet: UIButton!
    
    var collegeNames : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        print(collegeNames)
        //selected()

    }
/*
    func selected(){
    
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
        
            loginBtnOutlet.backgroundColor = UIColor.lightGray
            
        }
        else if self.emailTextField.text != "" || self.passwordTextField.text != ""  {
        
            loginBtnOutlet.backgroundColor = UIColor(red: 61, green: 93, blue: 154, alpha: 1)
            
        }
        
    }
*/
    @IBAction func loginBtn(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error == nil {
                
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newpageViewController")
                self.present(vc, animated: true, completion: nil)
                
                print("sucess login")
                
            
            }
            else if self.emailTextField.text == "" || self.passwordTextField.text == "" {
                
                let alert = UIAlertController(title: "Oops", message: "Please enter credentials", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            
            } else {
            
                let alert = UIAlertController(title: "oops", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
 
}
