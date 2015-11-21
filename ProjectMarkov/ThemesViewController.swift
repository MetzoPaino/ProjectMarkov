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
    
//    var testArray = [ThemeModel]()
    var dataManager: DataManager!
    
    var themesArray = [ThemeModel]()
    // MARK: - Setup View
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        themesArray = dataManager.themes
//        testArray.append(createTheOldManAndTheSeaTheme())
//        testArray.append(createHelloTheme())
//        testArray.append(createMrsDallowayTheme())
//        testArray.append(createConstellationTheme())
//        testArray.append(createTheOtherTheme())
//        testArray.append(createSacksTheme())
//        testArray.append(createQuestionsTheme())
//        testArray.append(createDirectQuotesTheme())
        
        var divider: CGFloat = 4.0
        
        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            divider = 1.0
        }
        
        let cellWidth = collectionView.bounds.width / divider
        
//        return CGSizeMake(cellWidth, cellWidth)
        
        
        collectionView.collectionViewLayout.invalidateLayout()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 10, height: 10)
        collectionView.collectionViewLayout = layout
    }
    
    func setupGestureRecognizers() {
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPressGesture:")
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
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
                
                controller.theme = themesArray[sender - 1]
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
        
        return themesArray.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath)
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! ThemeCollectionViewCell
//            cell.nameTextView.text = testArray[indexPath.row - 1].name
//            cell.nameTextView.font = UIFont.systemFontOfSize(28)
            cell.nameLabel.preferredMaxLayoutWidth = 100

            cell.nameLabel.text = themesArray[indexPath.row - 1].name

            return cell
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 16
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) {
            
            if selectedCell.reuseIdentifier == "AddCell" {
                
                self.performSegueWithIdentifier("PresentAddTheme", sender: self)
                
            } else {
                
                self.performSegueWithIdentifier("ShowMotifsVariations", sender: indexPath.row)
            }
        }
    }
    
    // MARK: - CollectionView Flow Layout
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        var divider: CGFloat = 4.0
//        
//        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
//            
//            divider = 1.0
//        }
//        
//        let cellWidth = CGRectGetWidth(collectionView.frame) / divider
//        
//        return CGSizeMake(cellWidth, cellWidth)
//    }
    
    // MARK: - NewModelControllerDelegate
    
    func newModelViewControllerCreateNewThemeWithName(name: String) {
        
        let theme = ThemeModel(name: name)
        themesArray.append(theme)
        collectionView.reloadData()
        
    }
}

