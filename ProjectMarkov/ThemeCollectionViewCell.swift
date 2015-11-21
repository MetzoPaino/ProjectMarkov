//
//  ThemeCollectionViewCell.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let label = UILabel(frame: self.bounds)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.lightGrayColor()
//        label.numberOfLines = 0
        /*
        
        This next line is needed to force the label to wrap words
        at the width of an iphone screen.
        
        Hardcoding this width is ugly. We'd prefer it if the
        label's preferredMaxLayoutWidth was dynamically set to the
        width of the view, which expanded to the width available to it,
        after all preceding items were layed out.
        
        This is a battle for another day.
        
        */
        nameLabel.preferredMaxLayoutWidth = 60
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
