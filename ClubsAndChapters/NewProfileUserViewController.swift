//
//  NewProfileUserViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 05/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class NewProfileUserViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var newsCollectionView: UICollectionView!
    @IBOutlet var infoBtn: UIBarButtonItem!
    
    var user : User!
    var eventposts : [eventPost] = []
    var newsposts : [newsPost] = []
    var userId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        newsCollectionView.dataSource = self
        
        collectionView.delegate = self
        newsCollectionView.delegate = self
        
        fetchUser()
        fetchMyEventPosts()
        fetchMyNewsPosts()

    }
    
    
    
      
    
    
    func fetchMyEventPosts() {
        
 
        Api.MyEventPosts.REF_MYEVENTPOSTS.child(userId).observe(.childAdded, with: {
            snapshot in
            
            print(snapshot)
            
            Api.Post.observePost(withId: snapshot.key, completion: { eventpost in
                print(eventpost.id)
                
                self.eventposts.append(eventpost)
                self.collectionView.reloadData()
            })
            
        })
        
    }
    
    func fetchMyNewsPosts() {

        Api.MyEventPosts.REF_MYNEWSPOSTS.child(userId).observe(.childAdded, with: { snapshot in
            
            
            
            Api.Post.observeNewsPost(withId: snapshot.key, completion: { newspost in
                print(newspost.id)
                self.newsposts.append(newspost)
                self.collectionView.reloadData()
            })
            
        })
        
        
    }
    
    
    
    
    func fetchUser() {
        
        Api.User.observeUser(withId: userId) { (user) in
            self.user = user
            self.collectionView.reloadData()

        }
        
    }


   }



extension NewProfileUserViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            
            
            return eventposts.count
            
        }
        else {
            
            
            return newsposts.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionView {
            
            let eventcell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventPhotoCollectionViewCell", for: indexPath) as! EventsPhotoCollectionViewCell
            let eventpost = eventposts[indexPath.row]
            eventcell.eventpost = eventpost
            return eventcell
            
        }
        else {
            
            let newscell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsPhotoCollectionViewCell", for: indexPath) as! NewsPhotoCollectionViewCell
            let newspost = newsposts[indexPath.row]
            newscell.newspost = newspost
            
            return newscell
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "NewHeaderViewCollectionReusableView", for: indexPath) as! NewHeaderViewCollectionReusableView
        if let user = self.user {
            
            headerViewCell.user = self.user
            
        }
        
        return headerViewCell
        
    }
    
}

extension NewProfileUserViewController : UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.collectionView {
            
            return 2
        }
        else {
            
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView {
            
            return 0
        }
        else {
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView {
            
            return CGSize(width: collectionView.frame.size.height / 3, height: collectionView.frame.size.height / 3)
        }
        else {
            
            return CGSize(width: collectionView.frame.size.height / 3, height: collectionView.frame.size.height / 3)
            
        }
    }
}








