//
//  MotifCollectionViewCell.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

class MotifCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var optionsButton: UIButton!
    
    var turnedOn = true
    
    func configureCell(turnedOn: Bool) {
        
        if turnedOn == true {
            label.textColor = .black
            self.backgroundColor = .white
        } else {
            label.textColor = .gray
            self.backgroundColor = .lightGray
        }
    }
}
