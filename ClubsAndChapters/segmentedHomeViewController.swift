//
//  segmentedHomeViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 30/05/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class segmentedHomeViewController: UIViewController {
    
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var newsView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedView: UISegmentedControl!
    @IBOutlet var eventsView: UIView!
        
    var eventposts = [eventPost]()
    var newsposts = [newsPost]()
    var users = [User]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            tableView.estimatedRowHeight = 435
            tableView.rowHeight = UITableViewAutomaticDimension
            
            newsTableView.estimatedRowHeight = 126
            newsTableView.rowHeight = UITableViewAutomaticDimension
            
            tableView.dataSource = self
            newsTableView.dataSource = self
            
            loadEventPosts()
            loadNewsPosts()
            
        
    }
    
 
    
    func loadNewsPosts() {
    
        FIRDatabase.database().reference().child("news").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let dict = snapshot.value as? [String : Any]{
                
                let newnewspost = newsPost.transformNewsPost(dict: dict, key: snapshot.key)
                self.fetchUser(uid: newnewspost.uid!, completed: { 
                    self.newsposts.append(newnewspost)
                    self.newsTableView.reloadData()

                })
            }
        }
    }
    
    func loadEventPosts() {
    
    
        FIRDatabase.database().reference().child("events").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let dict = snapshot.value as?[String : Any] {
                
                let neweventpost = eventPost.transformeventPost(dict: dict, key: snapshot.key)
                
                self.fetchUser(uid: neweventpost.uid!, completed: {
                
                    self.eventposts.append(neweventpost)
                    print(self.eventposts)
                    
                    self.tableView.reloadData()

                    
                })
            }
        }
    }
    
    func fetchUser(uid : String, completed: @escaping () -> Void) {
    
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: FIRDataEventType.value, with: { snapshot in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let user = User.transformUser(dict: dict, key: snapshot.key)
                self.users.append(user)
                completed()
            }
        })
    }

    @IBAction func segmentedAction(_ sender: Any) {
        
        switch segmentedView.selectedSegmentIndex {
        case 0:
            eventsView.isHidden = false
            newsView.isHidden = true
        case 1:
            eventsView.isHidden = true
            newsView.isHidden = false
        default:
            return
        }
        
    }
    
    
    @IBAction func camerabtn(_ sender: Any) {
        
        let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cameraId")
        self.present(vc , animated: true, completion: nil)

    }
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        AuthService.logout(onSuccess: {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstvc")
            self.present(vc , animated: true, completion: nil)
            
            print("sucess logout")
        })
        { (errorMessage) in
            print("error")
        }
    }
    
    
}

extension segmentedHomeViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView{
        
        return eventposts.count
        }else {
        
            return newsposts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell", for: indexPath) as! eventTableViewCell
        let eventpost = eventposts[indexPath.row]
        let user = users[indexPath.row]
        
        cell.eventpost = eventpost
        cell.user = user
        cell.delegate = self
        
        return cell
        }
        else  {
        
             let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath) as! newsPostsTableViewCell
            let newspost = newsposts[indexPath.row]
            let user = users[indexPath.row]
            
            cell.newspost = newspost
            cell.user = user
            cell.delegate = self
            
            
            //cell.newsPostImgView.image = UIImage(named: "place-holder")
            return cell
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Home_ProfileSegue" {
            
            let profileVC = segue.destination as! NewProfileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
        } else if segue.identifier == "Event_DetailSegue" {
            
            let eventDetailVC = segue.destination as! EventDetailViewController
            let eventpostId = sender as! String
            eventDetailVC.eventpostsId = eventpostId
        } else if segue.identifier == "News_DetailSegue" {
            
            let newsDetailVC = segue.destination as! NewsDetailViewController
            let newspostId = sender as! String
            newsDetailVC.newspostsId = newspostId
        } else if segue.identifier == "RegisterSegue" {
            
            let registerVC = segue.destination as! registerViewController
            let registereventpostId = sender as! String
            registerVC.registereventpostsId = registereventpostId
        }


    }

    
}


extension segmentedHomeViewController : eventTableViewCellDelegate {
    
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "Home_ProfileSegue", sender: userId)
    }
    
    func goToEventDetailVC(eventpostId: String) {
        performSegue(withIdentifier: "Event_DetailSegue", sender: eventpostId)
    }
    
    func goToRegisterVC(eventpostId: String) {
        performSegue(withIdentifier: "RegisterSegue", sender: eventpostId)
    }


}

extension segmentedHomeViewController : newsPostsTableViewCellDelegate {
    
    func newsToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "Home_ProfileSegue", sender: userId)
    }
    
    func goToNewsDetailVC(newspostId: String) {
        performSegue(withIdentifier: "News_DetailSegue", sender: newspostId)
    }
    
}


