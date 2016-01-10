//
//  CreationViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 10/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

extension CGFloat {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}

protocol CreationViewControllerDelegate: class {
    func creationViewControllerSaveNewVariation(variation: VariationModel)
}

class CreationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var deleteArea: UIView!
    
    @IBOutlet weak var deleteAreaHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!

    
    
    let marginSize = 16.0 as CGFloat

    var motifs = [MotifModel]()
    var variation = VariationModel(variation: [MarkovWord]())
    let markovGenerator = MarkovGenerator()
    
    var originalPosition = NSIndexPath()
    var proposedPosition = NSIndexPath()
    
    
    
    var selectedIndexPath2 = NSIndexPath()
    
    var movingCells = false
    
    
    
    
    
    private var snapshot: UIView?
    private var sourceIndexPath: NSIndexPath?
    
    
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    weak var delegate: CreationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deleteAreaHeightConstraint.constant = 0;
        view.layoutIfNeeded()
        
        variation = markovGenerator.composeMarkovChainFromStringsArray(createStringsArray(motifs))
        collectionView.reloadData()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        longPressGesture.minimumPressDuration = 0.25
        self.collectionView.addGestureRecognizer(longPressGesture)
        
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
        

        
//        var collectionViewLayout = CutOutCollectionViewLayout()
//        collectionViewLayout.delegate = self
//        collectionView.collectionViewLayout = CutOutCollectionViewLayout()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

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
    
    func animateDeleteArea(animateOnScreen:Bool) {
        
        let height: CGFloat = animateOnScreen ? 88 : 0

        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.deleteAreaHeightConstraint.constant = height
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
    
    private func updateSnapshotView(center:CGPoint, transform:CGAffineTransform, alpha:CGFloat) {
        
        if let snapshot = snapshot {
            
            snapshot.center = center
            snapshot.transform = transform
            snapshot.alpha = alpha
        }
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        if editing {
            return
        }
        
        let location = gesture.locationInView(collectionView)
        let indexPath = collectionView.indexPathForItemAtPoint(location)
        
        switch gesture.state {
            
            
            
        case .Began:
            if let indexPath = indexPath {
                
                sourceIndexPath = indexPath
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TextCollectionViewCell
                snapshot = cell.snapshot
                updateSnapshotView(cell.center, transform: CGAffineTransformIdentity, alpha: 1.0)
                collectionView.addSubview(snapshot!)
                cell.moving = true
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.updateSnapshotView(cell.center, transform: CGAffineTransformMakeScale(1.05, 1.05), alpha: 1.0)
                    
                })
                movingCells = true
                animateDeleteArea(true)
            }
            
            print(self.view.bounds.height - deleteArea.frame.height)

            
        case .Changed:
            
            self.snapshot?.center = location
            if let indexPath = indexPath {
                
                let temp = variation.variation.removeAtIndex(sourceIndexPath!.item)
                variation.variation.insert(temp, atIndex: indexPath.item)
                collectionView.moveItemAtIndexPath(sourceIndexPath!, toIndexPath: indexPath)
                sourceIndexPath = indexPath
                self.collectionView.reloadData()

            }
            
        default:
            print("Default")
            
            let cell = collectionView.cellForItemAtIndexPath(sourceIndexPath!) as! TextCollectionViewCell
            
            if (location.y + snapshot!.frame.height) > deleteArea.frame.origin.y {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    self.snapshot!.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    cell.moving = false
                    
                    }, completion: { (finished: Bool) -> Void in
                        self.snapshot!.removeFromSuperview()
                        self.snapshot = nil
                        self.variation.variation.removeAtIndex(self.sourceIndexPath!.item)
                        self.collectionView.reloadData()
                        self.animateDeleteArea(false)
                })
 
            } else {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.updateSnapshotView(cell.center, transform: CGAffineTransformIdentity, alpha: 1.0)
                    
                
                    }, completion: { (finished: Bool) -> Void in
                        cell.moving = false
                        self.snapshot!.removeFromSuperview()
                        self.snapshot = nil
                        self.animateDeleteArea(false)
                })
            }
            
            
            
            
            
            
            



            
            

        
        }
        
//        switch(gesture.state) {
//            
//        case UIGestureRecognizerState.Began:
////            movingCells = true
//            
//            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
//                break
//            }
//            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
//            
//            selectedIndexPath2 = selectedIndexPath
//            
//        case UIGestureRecognizerState.Changed:
////            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
//            
////            if let _ = collectionView.cellForItemAtIndexPath(selectedIndexPath2) {
////                
////                let point = gesture.locationInView(gesture.view!)
////                
////                let hitArea = self.view.hitTest(point, withEvent: nil)
////                
////                if hitArea == deleteArea {
////                    
////                    collectionView.endInteractiveMovement()
////                    variation.variation.removeAtIndex(selectedIndexPath2.item)
////                
////                }
////            }
////            
//            
//            
//        case UIGestureRecognizerState.Ended:
//            
//            
//            
//            
//            movingCells = false
////            collectionView.endInteractiveMovement()
//        default:
////            collectionView.cancelInteractiveMovement()
//        }
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
        cell.backgroundStackView.backgroundColor = .whiteColor()
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
    
//    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        
//        let temp = variation.variation.removeAtIndex(sourceIndexPath.item)
//        variation.variation.insert(temp, atIndex: destinationIndexPath.item)
//    }
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
        
//        if movingCells == true {
//            
//            if originalPosition.row == indexPath.row {
//                string = variation.variation[proposedPosition.row].word
//
//            } else if proposedPosition.row == indexPath.row {
//                
//                string = variation.variation[originalPosition.row].word
//
//            } else {
//                string = variation.variation[indexPath.row].word
//
//            }
//
//        } else {
//            
//        }
        
        string = variation.variation[indexPath.row].word
        
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

//extension UICollectionViewFlowLayout {
//
//    override public func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [NSIndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
//        
//        
//    
//    let context = super.invalidationContextForInteractivelyMovingItems(targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
//        
//        print("cray")
//        
////        self.delegate? = nil
//        
////       context.invalidateItemsAtIndexPaths([previousIndexPaths[0], targetIndexPaths[0]])
//
//        
//        
//        collectionView?.performBatchUpdates({ () -> Void in
//            self.collectionView?.moveItemAtIndexPath(previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
//
//            }, completion:nil)
//        
//        
////   collectionView?(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
//    
//    return context
//}
//}

