//
//  TextCollectionViewCell.swift
//  ProjectMarkov
//
//  Created by William Robinson on 22/11/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backgroundStackView: UIStackView!
    
    @IBOutlet weak var view: UIView!
    
    var moving: Bool = false {
        didSet {
            
            let alpha: CGFloat = moving ? 0.0 : 1.0
            label.alpha = alpha
            view.alpha = alpha
//            backgroundStackView.alpha = alpha
        }
    }
    
    var snapshot: UIView {
        get {
            let snapshot = snapshotViewAfterScreenUpdates(true)
            let layer = snapshot.layer
            layer.masksToBounds = false
            layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
            layer.shadowRadius = 5.0
            layer.shadowOpacity = 0.4
            return snapshot
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.preferredMaxLayoutWidth = 500
        backgroundStackView.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
