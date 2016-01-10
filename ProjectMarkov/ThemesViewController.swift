//
//  ThemesViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 03/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, NewModelViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    let marginSize = 16.0 as CGFloat
    var dataManager: DataManager!
    
    var themesArray = [ThemeModel]()
    // MARK: - Setup View
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        themesArray = dataManager.themes
        
        if let navigationController = navigationController {
            
            navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.translucent = true
            
            // Set vertical effect
            let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                type: .TiltAlongVerticalAxis)
            verticalMotionEffect.minimumRelativeValue = -20
            verticalMotionEffect.maximumRelativeValue = 20
            
            // Set horizontal effect
            let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                type: .TiltAlongHorizontalAxis)
            horizontalMotionEffect.minimumRelativeValue = -20
            horizontalMotionEffect.maximumRelativeValue = 20
            
            // Create group to combine both
            let group = UIMotionEffectGroup()
            group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
            
            // Add both effects to your view
            self.imageView.addMotionEffect(group)
            
        }

        
    }
    

    func setupGestureRecognizers() {
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // MAKR: - IBActions
    
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("PresentAddTheme", sender: self)
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PresentAddTheme" {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NewModelViewController
            controller.delegate = self
            
        } else if segue.identifier == "ShowMotifsVariations" {
            
            let controller = segue.destinationViewController as! ThemeViewController
            
            if let sender = sender as? Int {
                
                controller.theme = themesArray[sender]
            }
            
        }
    }
    
    // MARK: - UIGestureRecognizers
    
    func handleLongPressGesture(longPressGesture: UILongPressGestureRecognizer) {
        
//        if longPressGesture.state == UIGestureRecognizerState.Began {
//            
//            let locationInView = longPressGesture.locationInView(self.collectionView)
//            let indexPath = self.collectionView.indexPathForItemAtPoint(locationInView);
//            
//            if let index = indexPath {
//                
//                let cell = self.collectionView.cellForItemAtIndexPath(index)
//            }
//
//        } else {
//            
//            return
//        }
    }

    // MARK: - CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return themesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! TextCollectionViewCell

        cell.label.text = themesArray[indexPath.row].name

        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize / 4
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: marginSize, left: marginSize, bottom: marginSize, right: marginSize)
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("ShowMotifsVariations", sender: indexPath.row)
    }
    
    // MARK: - CollectionView Flow Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // Width
        
        var divider: CGFloat = 4.0
        
        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            divider = 1.0
        }
        
        let cellWidth = CGRectGetWidth(collectionView.frame) / divider
        
        // Height
        
        let string = themesArray[indexPath.row].name
        let rect = CGRectMake(0, 0, cellWidth - marginSize * 4, CGFloat.max)
        
        let label = UILabel(frame: rect)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        label.text = string
        label.sizeToFit()
        
        return CGSizeMake(cellWidth - marginSize * 2, label.bounds.height + marginSize * 2)
    }
    
    // MARK: - NewModelControllerDelegate
    
    func newModelViewControllerCreateNewThemeWithName(name: String) {
        
        let theme = ThemeModel(name: name)
        themesArray.append(theme)
        collectionView.reloadData()
        
    }
    
    // Estimated cell size code
    //        collectionView.collectionViewLayout.invalidateLayout()
    //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    //        layout.estimatedItemSize = CGSize(width: 320, height: 10)
    //        collectionView.collectionViewLayout = layout
    //        cell.nameLabel.preferredMaxLayoutWidth = 750

}

