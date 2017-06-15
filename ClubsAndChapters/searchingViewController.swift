//
//  searchingViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 18/03/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class searchingViewController: UIViewController {
    
    var searchBar = UISearchBar()
    var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "search"
        searchBar.frame.size.width = view.frame.size.width - 60
        
        let searchItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = searchItem
        
        doSearch()
        
        // Do any additional setup after loading the view.
    }
    func doSearch() {
        if let searchText = searchBar.text?.lowercased(){
            self.users.removeAll()
            self.tableView.reloadData()
        Api.User.queryUsers(withText: searchText, completion: { (user) in
            self.users.append(user)
            self.tableView.reloadData()
            
        }
    )}
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Search_ProfileSegue" {
            
            let profileVC = segue.destination as! NewProfileUserViewController
            let userId = sender as! String
            profileVC.userId = userId
        }
    }
}





extension searchingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch()
    }
}

extension searchingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleTableViewCell", for: indexPath) as! peopleTableViewCell
        let user = users[indexPath.row]
        cell.user = user
        cell.delegate = self
        return cell
    }

}

extension searchingViewController: PeopleTableViewCellDelegate {
    
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "Search_ProfileSegue", sender: userId)
    }
    
}


