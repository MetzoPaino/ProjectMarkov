//
//  ThemeModel.swift
//  ProjectMarkov
//
//  Created by William Robinson on 03/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import Foundation

struct ThemeModel {
    var name = ""
    
    var motifs = [MotifModel]()
    
    init(string: String) {
        name = string
    }
}

struct MotifModel {
    
    var text: String
    var selected = true
    init(string: String) {
        text = string
    }
}

struct VariationModel {
    
    var displayString: String!
    var variation = [MarkovWord]()

    init(variation: [MarkovWord]) {
        self.variation = variation
        displayString = createDisplayString(self.variation)
    }
    
    func createDisplayString(variation: [MarkovWord]) -> String {
        
        var string = String()
        
        for (index, word) in variation.enumerate() {
            
            string = string + word.word
            
            if index < variation.endIndex {
                string = string + " "
            }
        }
        return string
    }
}