//
//  HomeViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 15/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var segmentControlOutlet: UISegmentedControl!
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
}

    @IBAction func segmentControlAction(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (segmentControlOutlet.selectedSegmentIndex == 0) {
            let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventPostTableViewCell") as! EventPostTableViewCell
            return eventCell
        } else {
            let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsPostTableViewCell") as! NewsPostTableViewCell
            return newsCell
        }
    }
}
