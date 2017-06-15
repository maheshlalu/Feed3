//
//  newpageViewController.swift
//  ClubsAndChapters
//
//  Created by sri on 11/06/17.
//  Copyright © 2017 sri. All rights reserved.
//

import UIKit

class newpageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private(set) lazy var myViewControllers : [UIViewController] = {
        
        return [
            
            self.myViewControllersFunc("newcameraId"),
            self.myViewControllersFunc("neweventNewsId"),
            self.myViewControllersFunc("newprofileId"),
            
            ]
        
    }()
    
    private func myViewControllersFunc(_ identifer : String) -> UIViewController{
        
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifer)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        
        //setting intial view controller
        
        if let intialViewController = myViewControllers.first {
            
            self.setViewControllers([intialViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }

    //previews viewcontroller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //get index of currrnt viewcontroller
        guard let index = myViewControllers.index(of: viewController) else {
            
            return  nil
            
        }
        //get index of previous viewcontroller
        let previous = index - 1
        
        // avoiding crashing
        guard previous >= 0 else {
            
            return nil
            
        }
        
        guard myViewControllers.count > previous else {
            
            return nil
            
        }
        
        return myViewControllers[previous]
        
    }
    
    
    // go to next viewcontroller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // get index of current view controller
        guard let index = myViewControllers.index(of: viewController) else {
            
            return  nil
            
        }
        
        // get index of next view controller
        
        let next = index + 1
        
        
        // avoding crashes
        guard myViewControllers.count != next else {
            return nil
        }
        
        guard myViewControllers.count  > next else {
            return nil
        }
        return myViewControllers[next]
    }
    
}





