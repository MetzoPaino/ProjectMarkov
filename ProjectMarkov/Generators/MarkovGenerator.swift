//
//  MarkovGenerator.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

// MARK:- Classes

public class IndexedString {
    public var string: String
    public var index: Int
    
    public init(string: String, index: Int) {
        self.string = string
        self.index = index
    }
}

public class Prefix {
    public var indexedStrings: [IndexedString]
    
    public init(indexedStrings: [IndexedString]) {
        self.indexedStrings = indexedStrings
    }
}

public class Link {
    
    public var prefix: Prefix
    public var suffix: IndexedString
    
    public init(prefix: Prefix, suffix: IndexedString) {
        self.prefix = prefix
        self.suffix = suffix
    }
    
    public init(link: Link) {
        self.prefix = link.prefix
        self.suffix = link.suffix
    }
}

public class Chain {
    public var prefixes: [Prefix]
    public var suffix: String
    
    public init(prefixes: [Prefix], suffix: String) {
        self.prefixes = prefixes
        self.suffix = suffix
    }
}

// MARK:- Print


class markovGenerator {

    let testInput = "I am not a number! I am a free man! I am not a machine! I am a human being! I am not a statistic! I am a creature of this earth!"
    let prefixLength = 2
    let maxSentenceLength = 8
    
    var randomPick = 0
    var randomSuffix = 0
    var chunkLength = 6.0
    var currentChunkLength = 0.0
    
    // MARK:- Objects
    
    var constructedString = [IndexedString]()
    
//    func print(links:[Link]) {
//        
//        for link in links {
//            
//            print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)
//            
//            print("Prefix", separator:"", terminator: "")
//            let indexedStrings = link.prefix.indexedStrings
//            
//            for indexedString in indexedStrings {
//                
//                print(" [\(indexedString.string) - \(indexedString.index)]", terminator: "")
//            }
//            print(" - Suffix [\(link.suffix.string), \(link.suffix.index)]", terminator: "")
//            print("")
//        }
//    }
//    
//    func print(constructedString:[IndexedString]) {
//        
//        print("")
//        print("Current Constructed String")
//        
//        for indexedString in constructedString {
//            
//            print("[\(indexedString.string) - \(indexedString.index)] ", terminator: "")
//        }
//    }

    
//    print(testInput)
//    print(" ")
    func createLinkArray(stringArray: [String]) -> [Link] {
        
        var links = [Link]()
        
        for (index, _) in stringArray.enumerated() {
            
            var neededIndexes = [Int]()
            var neededIndex = index
            
            var indexedStrings = [IndexedString]()
            
            repeat {
                
                if stringArray.indices.contains(neededIndex) == true {
                    
                    let indexedString = IndexedString(string: stringArray[neededIndex], index: neededIndex)
                    indexedStrings.append(indexedString)
                }
                
                neededIndexes.append(neededIndex)
                neededIndex += 1
                
            } while neededIndexes.count < prefixLength
            
            let prefix = Prefix(indexedStrings: indexedStrings)
            
            if stringArray.indices.contains(neededIndex) == true {
                
                let suffix = IndexedString(string:stringArray[neededIndex], index: neededIndex)
                let link = Link(prefix: prefix, suffix: suffix)
                links.append(link)
            }
        }
        
        return links
    }
    
    func findMatchingPrefixes(selectedLink: Link, links: [Link]) -> [Link] {
        
        var matchingPrefixes = [Link]()
        
        for link in links {
            
            for (index, indexedString) in link.prefix.indexedStrings.enumerated() {
                
                if indexedString.string == selectedLink.prefix.indexedStrings[index].string {
                    
                    if index < link.prefix.indexedStrings.count - 1 {
                        continue
                    } else {
                        matchingPrefixes.append(link)
                    }
                    continue
                } else {
                    break
                }
            }
        }
        
        return matchingPrefixes
    }
    
    func appendPrefixToConstructedString(prefix: Prefix) {
        
        for (index, indexString) in prefix.indexedStrings.enumerated() {
            
            if index == 0 {
                if constructedString.count == 0 {
                    constructedString.append(indexString)
                }
            } else {
                constructedString.append(indexString)
            }
        }
    }
    
    func create(inputArray: [String]) -> [String] {
        
        // MARK:- Code
        
        var stringArray = [String]()

        
        
        for input in inputArray {
            
            stringArray.append(contentsOf: input.components(separatedBy: " "))
        }
        
        
        
        //stringArray = testInput.components(separatedBy: " ")
        //stringArray = aliceString().components(separatedBy: " ")
        //stringArray = enoString().components(separatedBy: " ")
        
        // Create prefix & suffix index array
        var links = createLinkArray(stringArray: stringArray)
        
//        if links.count < 100 {
//            print(links: links)
//        }
        
        var firstTime = true
        
        print("\n\n\nStarting a loop\n\n")
        
        while constructedString.count < maxSentenceLength {
            
            if firstTime == true || randomPick > links.count - 1 {
                randomPick = Int(arc4random_uniform(UInt32(links.count)))
                firstTime = false
            } else {
                
                randomPick += 1 // I think this needs to be based off the index of what was picked? Because even if it picks far away, it only moves up 1 from where it was so stays at the start
            }
            
            if randomPick > links.count - 1 {
                
                // If you're going to go over the array then we should start again
                firstTime = true
                currentChunkLength = 0
                continue
            }
            
            //print("\nrandom pick = \(randomPick)")
            
            var pickedLink = links[randomPick]
            //print("\nPicked link")
           // print(links: [pickedLink])
            
            var potentialSuffix = findMatchingPrefixes(selectedLink: pickedLink, links: links)
            
            //print("\nPotential paths")
           // print(links: potentialSuffix)
            
            randomSuffix = Int(arc4random_uniform(UInt32(potentialSuffix.count)))
            //print("\nrandom suffix = \(randomSuffix)")
            
            var randomLink = potentialSuffix[randomSuffix]
            //print("\nSelected link")
          //  print(links: [randomLink])
            
            for (index, link) in links.enumerated() {
                
                if link === randomLink {
                    //print("\nMatched link to index \(index)")
                  //  print(links: [link])
                    randomPick = index
                }
            }
            
            appendPrefixToConstructedString(prefix: randomLink.prefix)
            currentChunkLength += 1
            
            var chunkPercentage = (chunkLength - currentChunkLength)
            chunkPercentage = chunkPercentage / chunkLength
            chunkPercentage = chunkPercentage * 100
            
            //print("\nchunk at length \(currentChunkLength) - \(String(format: "%.f", chunkPercentage))%")
            
            let pass = Double(arc4random_uniform(UInt32(100)))
            //print("pass attempt \(pass)")
            
            if pass > chunkPercentage {
                //print("We are moving on")
                firstTime = true
                currentChunkLength = 0
            }
            
            //print(constructedString: constructedString)
            //print("\n\n--")
        }
        
        var string = [String]()
        
        for indexString in constructedString {
            
            
            string.append(indexString.string)
            
        }
        return string
        
    }
    
    }

