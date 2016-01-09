//
//  CreationViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 10/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

protocol CreationViewControllerDelegate: class {
    func creationViewControllerSaveNewVariation(variation: VariationModel)
}

class CreationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let marginSize = 16.0 as CGFloat

    var motifs = [MotifModel]()
    var variation = VariationModel(variation: [MarkovWord]())
    let markovGenerator = MarkovGenerator()
    
    var originalPosition = NSIndexPath()
    var proposedPosition = NSIndexPath()
    
    var movingCells = false
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    weak var delegate: CreationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        variation = markovGenerator.composeMarkovChainFromStringsArray(createStringsArray(motifs))
        collectionView.reloadData()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        longPressGesture.minimumPressDuration = 0.25
        self.collectionView.addGestureRecognizer(longPressGesture)
        
//        var collectionViewLayout = CutOutCollectionViewLayout()
//        collectionViewLayout.delegate = self
//        collectionView.collectionViewLayout = CutOutCollectionViewLayout()
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func generateButtonPressed(sender: UIBarButtonItem) {
        
        variation = markovGenerator.composeMarkovChainFromStringsArray(createStringsArray(motifs))
        collectionView.reloadData()
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        variation.displayString = variation.createDisplayString(variation.variation)
        delegate?.creationViewControllerSaveNewVariation(variation)
        variation = markovGenerator.composeMarkovChainFromStringsArray(createStringsArray(motifs))
        collectionView.reloadData()
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
//            movingCells = true
            
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            movingCells = false
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func createStringsArray(motifs: [MotifModel]) -> [String] {
        
        var stringsArray = [String]()
        
        for motif in motifs {
            
            stringsArray.append(motif.text)
        }
        return stringsArray
    }
}

extension CreationViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return variation.variation.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! TextCollectionViewCell
        cell.label.text = variation.variation[indexPath.row].word
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return marginSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: marginSize, left: marginSize, bottom: marginSize, right: marginSize)
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let temp = variation.variation.removeAtIndex(sourceIndexPath.item)
        variation.variation.insert(temp, atIndex: destinationIndexPath.item)
    }
}

extension CreationViewController: UICollectionViewDelegate {

    // MARK: - CollectionView Delegate
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//    }
    
//    func collectionView(collectionView: UICollectionView, targetIndexPathForMoveFromItemAtIndexPath originalIndexPath: NSIndexPath, toProposedIndexPath proposedIndexPath: NSIndexPath) -> NSIndexPath {
//        
//        if originalIndexPath.row == proposedIndexPath.row {
//            print("Staying")
//            originalPosition = originalIndexPath
//            proposedPosition = proposedIndexPath
//        } else {
//            print("moving")
//            
//            originalPosition = originalIndexPath
//            proposedPosition = proposedIndexPath
//            
//            collectionView.performBatchUpdates({ () -> Void in
//                collectionView.collectionViewLayout.invalidateLayout()
//                }, completion: nil)
//        }
//        return proposedIndexPath
//    }
}

extension CreationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // Width & Height
        
        var string = String()
        
        if movingCells == true {
            
            if originalPosition.row == indexPath.row {
                string = variation.variation[proposedPosition.row].word

            } else if proposedPosition.row == indexPath.row {
                
                string = variation.variation[originalPosition.row].word

            } else {
                string = variation.variation[indexPath.row].word

            }

        } else {
            string = variation.variation[indexPath.row].word
        }
        
        let rect = CGRectMake(0, 0, CGFloat.max, CGFloat.max)
        
        let label = UILabel(frame: rect)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        label.text = string
        label.sizeToFit()
        
        return CGSizeMake(label.bounds.width + marginSize * 2, label.bounds.height + marginSize * 2)
    }
}

//extension CreationViewController {
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        // Width & Height
//        
//        let string = variation.variation[indexPath.row].word
//        let rect = CGRectMake(0, 0, CGFloat.max, CGFloat.max)
//        
//        let label = UILabel(frame: rect)
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
//        label.text = string
//        label.sizeToFit()
//        
//        return CGSizeMake(label.bounds.width + marginSize * 2, label.bounds.height + marginSize * 2)
//    }
//}
