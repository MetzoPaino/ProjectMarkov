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
    
    let marginSize = 16.0 as CGFloat

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
            
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ContentCell", forIndexPath: indexPath) as! TextCollectionViewCell
        let variation = variations[indexPath.row]
        
        cell.label.text = variation.displayString
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var divider: CGFloat = 4.0
        
        if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            divider = 1.0
        }
        
        let cellWidth = CGRectGetWidth(collectionView.frame) / divider
        
        // Height
        
        let variation = variations[indexPath.row]
        let string = variation.displayString
        let rect = CGRectMake(0, 0, cellWidth - marginSize * 4, CGFloat.max)
        
        let label = UILabel(frame: rect)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        label.text = string
        label.sizeToFit()
        
        return CGSizeMake(cellWidth - marginSize * 2, label.bounds.height + marginSize * 2)
    }
}
