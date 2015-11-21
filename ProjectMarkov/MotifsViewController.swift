//
//  MotifsViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

protocol MotifsViewControllerDelegate: class {
    func motifsViewControllerReceivedVariation(variation: VariationModel)
}

class MotifsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewModelViewControllerDelegate, CreationViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createMarkovStringButton: UIButton!
    var motifs = [MotifModel]()
    
    weak var delegate: MotifsViewControllerDelegate?
    
    // MARK: - Setup View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    override func viewWillLayoutSubviews() {
        collectionView.reloadData()
    }
    
    func styleView() {
        
        let disabledImage = UIImage.imageWithColor(.redColor())
        let enabledImage = UIImage.imageWithColor(.blueColor())

        createMarkovStringButton.setBackgroundImage(enabledImage, forState: .Normal)
        createMarkovStringButton.setBackgroundImage(disabledImage, forState: .Disabled)
        createMarkovStringButton.enabled = shouldButtonBeEnabled(motifs)
    }
    
    // MARK: - Calculations
    
    func shouldButtonBeEnabled(motifs: [MotifModel]) -> Bool {
        
        var selectedMotifs = [MotifModel]()
        
        for motif in motifs {
            
            if motif.selected {
                selectedMotifs.append(motif)
            }
        }
        
        if selectedMotifs.count > 0 {
            
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PresentAddMotif" {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! NewModelViewController
            controller.delegate = self
            
        } else if segue.identifier == "PresentComposeView" {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! CreationViewController
            controller.delegate = self
            
            var selectedMotifs = [MotifModel]()
            
            for motif in motifs {
                
                if motif.selected {
                    selectedMotifs.append(motif)
                }
            }
            
            controller.motifs = selectedMotifs
        }
    }

    // MARK: - CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return motifs.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath)
            return cell
            
        } else {
            
            let motif = motifs[indexPath.row - 1]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! ThemeCollectionViewCell
            cell.nameTextView.text = motif.text
            cell.selected = true;
            
            if motif.selected {
                
                cell.backgroundColor = .greenColor()
                
            } else {
                
                cell.backgroundColor = .lightGrayColor()
            }
            
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) {
            
            if selectedCell.reuseIdentifier == "AddCell" {
                
                self.performSegueWithIdentifier("PresentAddMotif", sender: self)
                
            } else if selectedCell.reuseIdentifier == "ContentCell"{
                
                motifs[indexPath.row - 1].selected = !motifs[indexPath.row - 1].selected
                
                createMarkovStringButton.enabled = shouldButtonBeEnabled(motifs)

                collectionView.reloadItemsAtIndexPaths([indexPath])
            }
        }
    }
    
    // MARK: - CollectionView Flow Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var divider: CGFloat = 4.0
        
        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            divider = 2.0
        }
        
        let cellWidth = CGRectGetWidth(collectionView.frame) / divider
        
        return CGSizeMake(cellWidth, cellWidth)
    }

    // MARK: - NewModelControllerDelegate
    
    func newModelViewControllerCreateNewThemeWithName(name: String) {
        
        let motif = MotifModel(string: name)
        motifs.append(motif)
        collectionView.reloadData()
    }
    
    // MARK: - CreationViewControllerDelegate
    
    func creationViewControllerSaveNewVariation(variation: VariationModel) {
        
        delegate?.motifsViewControllerReceivedVariation(variation)
    }
}
