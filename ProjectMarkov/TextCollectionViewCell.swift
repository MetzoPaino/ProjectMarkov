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

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.preferredMaxLayoutWidth = 50
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
