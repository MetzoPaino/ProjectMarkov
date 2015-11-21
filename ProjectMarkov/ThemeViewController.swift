//
//  MotifsVariationsViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController, MotifsViewControllerDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var tabBar: UITabBarController!
    weak var variationsViewController: VariationsViewController!
    
    var theme = ThemeModel(name: "")

    // MARK: - Setup View

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupTabBar() {
        
        tabBar.tabBar.hidden = true
    }
    
    func setupNavigationBar() {
        
        self.title = theme.name
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EmbedTabBar" {
            
            tabBar = segue.destinationViewController as! UITabBarController
            setupTabBar()
            
            if let views = tabBar.viewControllers {
                for view in views {
                    
                    if view is MotifsViewController {
                        
                        let controller = view as! MotifsViewController
                        controller.motifs = theme.motifs
                        controller.delegate = self
                        
                    } else if view is VariationsViewController {
                        
                        variationsViewController = view as! VariationsViewController
                        variationsViewController.variations = theme.variations
                    }
                }
            }
        }
    }
    
    // MARK: - IBActions

    @IBAction func segmentedControlPressed(sender: UISegmentedControl) {
        
        self.tabBar.selectedIndex = segmentedControl.selectedSegmentIndex
    }
    
    // MARK: - MotifsViewControllerDelegate
    
    func motifsViewControllerReceivedVariation(variation: VariationModel) {
        
        theme.variations.append(variation)
        variationsViewController.receiveNewVariation(variation)
    }
}
