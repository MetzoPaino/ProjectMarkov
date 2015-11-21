//
//  VariationsViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 07/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

class VariationsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var variations = [VariationModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView.reloadData()
    }
    
    // MARK: -
    
    func receiveNewVariation(variation: VariationModel) {
        
        variations.append(variation)
    }
    
    // MARK: - CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return variations.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! ThemeCollectionViewCell
        let variation = variations[indexPath.row]
        
        cell.nameTextView.text = variation.displayString
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - CollectionView Flow Layout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let cellWidth = CGRectGetWidth(collectionView.frame) / 3
        
        return CGSizeMake(cellWidth, cellWidth)
    }
}
