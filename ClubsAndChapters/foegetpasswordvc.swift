//
//  foegetpasswordvc.swift
//  ClubsAndChapters
//
//  Created by sri on 11/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import Firebase

class foegetpasswordvc: UIViewController {

    @IBOutlet weak var forgetpasswordtextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
    }
    
    
    @IBAction func forgetpasswordbutton(_ sender: Any) {
        
        view.endEditing(true)
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: forgetpasswordtextfield.text!) { (error) in
            
            if error == nil{
                
            
                
                let alert = UIAlertController(title: "sucess", message: "link has been sent to registered email", preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert, animated: true, completion: nil)

                
                print("reset email has been sent")
                
            }
            else if self.forgetpasswordtextfield.text! == ""{
                let alert = UIAlertController(title: "oops!", message: "enter credits", preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert, animated: true, completion: nil)
                
                
                print("error")
            }
                
            else{
                let alert = UIAlertController(title: "oops!", message: (error?.localizedDescription), preferredStyle: .alert)
                let defaultaction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(defaultaction)
                self.present(alert, animated: true, completion: nil)
                
                
            }
        }

        
    }
    
    
    
    
    
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
