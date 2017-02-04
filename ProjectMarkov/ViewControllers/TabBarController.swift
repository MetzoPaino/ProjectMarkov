//
//  TabBarController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, MarkovViewControllerDelegate, MotifViewControllerDelegate {

    var markovViewController = MarkovViewController()
    var variationController = VariationsViewController()
    var motifViewController = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        motifViewController = self.viewControllers![0] as! ViewController
        motifViewController.delegate = self
        
        variationController = self.viewControllers![1] as! VariationsViewController
       // variationController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ModalMarkov" {
            
            let navigationController = segue.destination as! UINavigationController
            markovViewController = navigationController.topViewController as! MarkovViewController
            markovViewController.delegate = self
        }
        
        
    }
    
    func presentMarkovViewController() {
        self.performSegue(withIdentifier: "ModalMarkov", sender: self)
    }
    
    func createdVariation(variation: [String]) {
        
        variationController.appendVariationToArray(array: variation)
    }
 

}
