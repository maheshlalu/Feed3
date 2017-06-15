//
//  mainViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 11/02/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import Firebase

class mainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageViewControllerId")
            self.present(vc , animated: true, completion: nil)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
