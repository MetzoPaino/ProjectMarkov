//
//  VariationManager.swift
//  ProjectMarkov
//
//  Created by William Robinson on 23/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import Foundation

class VariationManager: DataManager {
    
//    func variationCount() -> Int {
//        
//        return variations.count
//    }
//    
//    func appendVariationToArray(array: [String]) {
//        variations.append(array)
//    }
//    
//    func variationArrayForIndex(index: Int) -> [String] {
//        return variations[index]
//    }
}

extension DataManager {
    
    func variationCount() -> Int {
        
        return variations.count
    }
    
    func appendVariationToArray(array: [String]) {
        variations.append(array)
    }
    
    func variationArrayForIndex(index: Int) -> [String] {
        return variations[index]
    }
}
