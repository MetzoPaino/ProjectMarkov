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

class CreationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let marginSize = 16.0 as CGFloat

    var motifs = [MotifModel]()
    var variation = VariationModel(variation: [MarkovWord]())
    let markovGenerator = MarkovGenerator()
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    weak var delegate: CreationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        variation = markovGenerator.composeMarkovChainFromStringsArray(createStringsArray(motifs))
        collectionView.reloadData()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        self.collectionView.addGestureRecognizer(longPressGesture)
        
        collectionView.collectionViewLayout.invalidateLayout()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 10, height: 10)
        collectionView.collectionViewLayout = layout
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
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
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
    
    
    // MARK: - CollectionView Data Source
    
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
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: - CollectionView Flow Layout
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        return CGSizeMake(20, 20)
//        
//        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
//            
//            print(cell.bounds.size)
//            return cell.bounds.size
//
//        } else {
//            
//            return CGSizeMake(20, 20)
//        }
////        let cellWidth = CGRectGetWidth(collectionView.frame) / 3
//        // I think this should return the size of the cell that it already is?
//
////        return CGSizeMake(cellWidth, cellWidth)
//    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let temp = variation.variation.removeAtIndex(sourceIndexPath.item)
        variation.variation.insert(temp, atIndex: destinationIndexPath.item)
        
        for word in variation.variation {
            
            print(word)
        }
    }
}
