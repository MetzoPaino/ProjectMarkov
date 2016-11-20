//
//  ShuffleGenerator.swift
//  ProjectMarkov
//
//  Created by William Robinson on 20/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

class ShuffleGenerator {

    func createString(stringArray:[String]) -> String {
        
        
        
        let wordArray = createWordArray(strings: stringArray)
        let randomString = createRandomString(words: wordArray)
        
        
        return randomString
    }
    
    func createWordArray(strings:[String]) -> [String] {
        
        var wordArray = [String]()
        
        for string in strings {
            
            let stringComponents = (string.components(separatedBy: " "))
            wordArray.append(contentsOf: stringComponents)
        }
        
        return wordArray
    }
    
    func createRandomString(words: [String]) -> String {
        
        let maximumLength = Int(arc4random_uniform(UInt32(words.count)))
        var usedIndexes = [Int]()
        var randomString = ""
        for _ in (0...maximumLength) {
            
            let randomNumber = Int(arc4random_uniform(UInt32(words.count)))
            
            if usedIndexes.contains(randomNumber) {
                
                continue
                
            } else {
                
                usedIndexes.append(randomNumber)
                randomString.append("\(words[randomNumber]) ")
            }
        }
        return randomString
    }
}
