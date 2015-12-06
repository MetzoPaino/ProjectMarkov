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
    
    let marginSize = 16.0 as CGFloat
    
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
        let enabledImage = UIImage.imageWithColor(self.view.tintColor)

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
        
        return motifs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let motif = motifs[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! TextCollectionViewCell
        cell.label.text = motif.text
        cell.selected = true;
        
        if motif.selected {
            
            cell.backgroundColor = .whiteColor()
            
        } else {
            
            cell.backgroundColor = .lightGrayColor()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: marginSize, left: marginSize, bottom: marginSize * 2 + 44, right: marginSize)
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        motifs[indexPath.row].selected = !motifs[indexPath.row].selected
        
        createMarkovStringButton.enabled = shouldButtonBeEnabled(motifs)
        
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    // MARK: - CollectionView Flow Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var divider: CGFloat = 4.0
        
        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            divider = 1.0
        }
        
        let cellWidth = CGRectGetWidth(collectionView.frame) / divider
        
        // Height
        
        let string = motifs[indexPath.row].text
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
        
        let motif = MotifModel(string: name)
        motifs.append(motif)
        collectionView.reloadData()
    }
    
    // MARK: - CreationViewControllerDelegate
    
    func creationViewControllerSaveNewVariation(variation: VariationModel) {
        
        delegate?.motifsViewControllerReceivedVariation(variation)
    }
}
