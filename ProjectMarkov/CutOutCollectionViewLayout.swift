//
//  CutOutCollectionViewLayout.swift
//  ProjectMarkov
//
//  Created by William Robinson on 06/12/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

@objc protocol CutOutCollectionViewLayoutDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView (collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    
//    optional func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        heightForHeaderInSection section: NSInteger) -> CGFloat
//    
//    optional func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        heightForFooterInSection section: NSInteger) -> CGFloat
//    
//    optional func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAtIndex section: NSInteger) -> UIEdgeInsets
//    
//    optional func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAtIndex section: NSInteger) -> CGFloat
}

class CutOutCollectionViewLayout: UICollectionViewLayout {

    weak var delegate : CutOutCollectionViewLayoutDelegate?{
        get{
            return self.collectionView!.delegate as? CutOutCollectionViewLayoutDelegate
        }
    }
    
//    weak var delegate: CutOutCollectionViewLayoutDelegate?
    
    internal override func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [NSIndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContextForInteractivelyMovingItems(targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
//        self.delegate?.collectionView!(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
        
        return context
    }
}
