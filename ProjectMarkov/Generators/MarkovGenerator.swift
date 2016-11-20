//
//  MarkovGenerator.swift
//  ProjectMarkov
//
//  Created by William Robinson on 20/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation



class MarkovGenerator {
    
    let statement = "I am not a number! I am a free man!"
    let prefixLength = 2
    
    // Prefix is a Markov chain prefix of one or more words.
    typealias Prefix = [String]
    
    
    
    func createMarkovChain(array:[String]) -> String {
        
        //let prefixes = createPrefixes(array: array)
        
        
        return "!"
    }
    
//    func createPrefixes(array:[String]) -> [Prefix] {
//        
//        var prefixArray = [Prefix]()
//        
//        for string in array {
//            
//            var stringArray = string.components(separatedBy: " ")
//            
//            for (index, word) in stringArray.enumerated() {
//                
//                let shiftedCount = stringArray.count - 1
//                let nextWordIndex = index + 1
//                
//                if nextWordIndex <= shiftedCount {
//                    
//                    let prefix = [word, stringArray[nextWordIndex]]
//                    prefixArray.append(prefix)
//                }
//                
//                print("Index = \(index) / count \(stringArray.count)")
//            }
//            
//            print(stringArray)
//            print(prefixArray)
//        }
//        
//        //prefixArray = removePrefixDuplicates(originalPrefixes: prefixArray)
//        return prefixArray
//    }

//    func removePrefixDuplicates(originalPrefixes: [Prefix]) -> [Prefix] {
//        
//        for Prefix in originalPrefixes {
//            
//            
//        }
//    }
}
