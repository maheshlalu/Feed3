//
//  collegeListTableViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 10/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class collegeListTableViewController: UITableViewController {
    

    var collegeNames : [String]!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collegeNames = ["vit-bhopal","vit-vijayawada","Vit-Vellore","Vit-chennai"]
    }

   
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeNamesCell", for: indexPath)

        cell.textLabel?.text = collegeNames[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ToDetailViewController",let destination = segue.destination as? DetailViewController
//        {
//            if let cell = sender as? UITableViewCell, let indexpath = tableView.indexPath(for: cell){
//                destination.city = cities[indexpath.row]
//            }
//        }

        if segue.identifier == "goBackToLoginViewController", let destination = segue.destination as? LoginViewController {
            if let cell = sender as? UITableViewCell, let indexpath = tableView.indexPath(for: cell) {
            
            destination.collegeNames = collegeNames[indexpath.row]
            }
        }
        
        
    }
 
}
