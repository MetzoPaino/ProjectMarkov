//
//  MarkovGenerator.swift
//  ProjectMarkov
//
//  Created by William Robinson on 10/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

/*

Markov generation will work like thus,

When finding new words you can’t cascade into another sentence, if you run out of words you use the last word as a new jumping off point

You can’t remove selected words as sentences will no longer make sense, instead it will need to find another jumping off point. For example, if you are at the start of a sentence, and the middle part has already been used, it won’t skip them and start using the end of the sentence, the last unused word is the new jumping off point

*/

import UIKit
import GameplayKit

// MARK: - Shuffle
// http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift

extension CollectionType where Index == Int {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

struct PrefixesAndSuffix {
    
    var prefixes = [MarkovWord]()
    var suffix = MarkovWord(word: "", index: (0,0), hasBeenUsed: false)
}

struct MarkovPart {
    
    var wordsArray = [MarkovWord]()
}

let printToLog = false

class MarkovWord: NSObject, NSCoding {
    
    let wordKey = "word"
    let indexSectionKey = "indexSection"
    let indexPointKey = "indexPoint"
    let hasBeenUsedKey = "hasBeenUsed"

    var word = ""
    var index = (section: Int(), point: Int())
    var hasBeenUsed = false
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedWord = aDecoder.decodeObjectForKey(wordKey) as? String {
            
            word = decodedWord
            
        } else {
            
            word = "?!?"
        }
        
        if let decodedIndexSection = aDecoder.decodeObjectForKey(indexSectionKey) as? Int {
            
            index.section = decodedIndexSection
        }
        
        if let decodedIndexPoint = aDecoder.decodeObjectForKey(indexPointKey) as? Int {
            
            index.point = decodedIndexPoint
        }
        
        if let decodedHasBeenUsed = aDecoder.decodeObjectForKey(hasBeenUsedKey) as? Bool {
            
            hasBeenUsed = decodedHasBeenUsed
        }
        
        super.init()
    }
    
    init(word: String, index: (Int, Int), hasBeenUsed: Bool) {
        
        self.word = word
        self.index = index
        self.hasBeenUsed = hasBeenUsed
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        if printToLog {
            print("Saving Markov Word")
        }
        aCoder.encodeObject(wordKey, forKey: word)
        aCoder.encodeObject(index.section, forKey: indexSectionKey)
        aCoder.encodeObject(index.point, forKey: indexPointKey)
        aCoder.encodeObject(hasBeenUsed, forKey: hasBeenUsedKey)
    }
}

//extension MarkovWord {
//    class HelperClass: NSObject, NSCoding {
//
//        var markovWord: MarkovWord?
//
//        init(markovWord: MarkovWord) {
//            self.markovWord = markovWord
//            super.init()
//        }
////
////        class func path() -> String {
////            let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
////            let path = documentsPath?.stringByAppendingString("/Person")
////            return path!
////        }
////
//        required init?(coder aDecoder: NSCoder) {
//            guard let word = aDecoder.decodeObjectForKey("word") as? String else {
//                markovWord = nil;
//                super.init();
//                return nil
//            }
//            
//            guard let indexSection = aDecoder.decodeObjectForKey("indexSection") as? Int else {
//                markovWord = nil;
//                super.init();
//                return nil
//            }
//            
//            guard let indexPoint = aDecoder.decodeObjectForKey("indexPoint") as? Int else {
//                markovWord = nil;
//                super.init();
//                return nil
//            }
//            
//            guard let hasBeenUsed = aDecoder.decodeObjectForKey("hasBeenUsed") as? Bool else {
//                markovWord = nil;
//                super.init();
//                return nil
//            }
//            let index = (indexSection, indexPoint)
//            markovWord = MarkovWord(word: word, index: index, hasBeenUsed: hasBeenUsed)
//
//            super.init()
//        }
//
//        func encodeWithCoder(aCoder: NSCoder) {
//            
//            print("Encoding Markov Word")
//            aCoder.encodeObject(markovWord!.word, forKey: "word")
//            aCoder.encodeObject(markovWord!.index.section, forKey: "indexSection")
//            aCoder.encodeObject(markovWord!.index.point, forKey: "indexPoint")
//            aCoder.encodeObject(markovWord!.hasBeenUsed, forKey: "hasBeenUsed")
//        }
//    }
//}


enum FindStartingWordsError: ErrorType {
    
    case UnableToFindFirstWord()
    case UnableToFindSecondWord(firstWord: MarkovWord, UnableToFindWordReasonError)
    case UnableToFindThirdWord(firstWord: MarkovWord, secondWord: MarkovWord)
}

enum UnableToFindWordReasonError: ErrorType {
    
    case NoWordAvailable
    case WordAlreadyUsed
}

enum FindSuffixWordError: ErrorType {
    
    case UnableToFindSuffix
}

class MarkovGenerator {
    
    // TODO: - Should this have a "with extras" struct that defines variation length etc?
    
    let prefixDepth = 2
    
    func composeMarkovChainFromStringsArray(let stringsArray: [String]) -> VariationModel {
        
        /*
            Step 1 - Convert the stringsArray to a markovArray of MarkovWords
        */
        
        var markovArray = convertStringsArrayToMarkovWordArray(stringsArray)
        
        /*
            Step 2 - Pick starting words
            Create a random seed for the starting index, then pick the 3 words after
        */
        
        let variationLength = generateRandomSeedFromLowestValueToHighestValue(10, highestValue: 20)
        var variationArray = [MarkovWord]()
        var sectionLength = 0
        var currentSectionLength = 0

        if printToLog {
            print("We want to get \(variationLength) words")
        }
        
        while variationArray.count < variationLength {
            
            if currentSectionLength == 0 {
                
                sectionLength = generateRandomSeedFromLowestValueToHighestValue(4, highestValue: 10)
                
                if printToLog {
                    print("The section length = \(sectionLength)")
                }
            }
            
            if currentSectionLength >= sectionLength {
                
                currentSectionLength = 0
                if printToLog {
                    print("We have spent too long on one section, find a new one")
                }
                do {
                    
                    let randomSeed = generateRandomSeedFromLowestValueToHighestValue(markovArray.startIndex, highestValue: markovArray.endIndex.predecessor())
                    
                    let startingWordsTuple = try pickStartingWordsFromMarkovPart(markovArray[randomSeed])
                    markovArray = updateMarkovWordInMarkovArray([startingWordsTuple.firstWord, startingWordsTuple.secondWord, startingWordsTuple.thirdWord], markovArray: markovArray)
                    variationArray.append(startingWordsTuple.firstWord)
                    variationArray.append(startingWordsTuple.secondWord)
                    variationArray.append(startingWordsTuple.thirdWord)
                    currentSectionLength += 3
                    
                } catch {
                    
                    if let error = error as? FindStartingWordsError {
                        
                        let errorResponse = handleFindStartingWordsError(error, markovArray: markovArray, variationArray: variationArray, currentSectionLength: currentSectionLength)
                        markovArray = errorResponse.markovArray
                        variationArray = errorResponse.variationArray
                        currentSectionLength = errorResponse.currentSectionLength
//                        switch error {
//
//                        case .UnableToFindFirstWord():
//                            // Can't do anything, most likely every word has been used
//                            break
//                            
//                        case .UnableToFindSecondWord(let firstWord, let UnableToFindWordReasonError):
//                            
//                            // If no word was found we don't do anything & try to find starting words again
//                            // If it failed because the word was already used we add it just to move things along
//                            
//                            if UnableToFindWordReasonError == .WordAlreadyUsed {
//                                
//                                markovArray = updateMarkovWordInMarkovArray([firstWord], markovArray: markovArray)
//                                variationArray.append(firstWord)
//                                currentSectionLength += 1
//                            }
//                            
//                            break
//                            
//                        case .UnableToFindThirdWord(let firstWord, let secondWord):
//                            markovArray = updateMarkovWordInMarkovArray([firstWord, secondWord], markovArray: markovArray)
//                            variationArray.append(firstWord)
//                            variationArray.append(secondWord)
//                            
//                            currentSectionLength += 2
//                            
//                            break
//                        }
                    }
                }
                
                break
                
            } else {
                
                do {
                    
                    let suffix = try searchForSuffixWithPrefixArrayFromMarkovPartArray(variationArray, markovPartArray: markovArray)
                    markovArray = updateMarkovWordInMarkovArray([suffix], markovArray: markovArray)
                    variationArray.append(suffix)
                    currentSectionLength++
                    
                } catch {
                    if printToLog {
                        print("Need new starting point")
                    }
                    
                    if let error = error as? FindSuffixWordError {
                        
                        switch error {
                            
                        case .UnableToFindSuffix:
                            
                            do {
                                
                                let randomSeed = generateRandomSeedFromLowestValueToHighestValue(markovArray.startIndex, highestValue: markovArray.endIndex.predecessor())
                                
                                let startingWordsTuple = try pickStartingWordsFromMarkovPart(markovArray[randomSeed])
                                markovArray = updateMarkovWordInMarkovArray([startingWordsTuple.firstWord, startingWordsTuple.secondWord, startingWordsTuple.thirdWord], markovArray: markovArray)
                                variationArray.append(startingWordsTuple.firstWord)
                                variationArray.append(startingWordsTuple.secondWord)
                                variationArray.append(startingWordsTuple.thirdWord)
                                currentSectionLength += 3
                                
                            } catch {
                                
                                if let error = error as? FindStartingWordsError {
                                    
                                    let errorResponse = handleFindStartingWordsError(error, markovArray: markovArray, variationArray: variationArray, currentSectionLength: currentSectionLength)
                                    markovArray = errorResponse.markovArray
                                    variationArray = errorResponse.variationArray
                                    currentSectionLength = errorResponse.currentSectionLength
                                    
//                                    switch error {
//                                        
//                                    case .UnableToFindFirstWord():
//                                        break
//                                        
//                                    case .UnableToFindSecondWord(let firstWord, let UnableToFindWordReasonError):
//                                        
//                                        // If no word was found we don't do anything & try to find starting words again
//                                        // If it failed because the word was already used we add it just to move things along
//                                        
//                                        if UnableToFindWordReasonError == .WordAlreadyUsed {
//                                            
//                                            markovArray = updateMarkovWordInMarkovArray([firstWord], markovArray: markovArray)
//                                            variationArray.append(firstWord)
//                                            currentSectionLength += 1
//                                        }
//                                        
//                                        break
//                                        
//                                    case .UnableToFindThirdWord(let firstWord, let secondWord):
//                                        markovArray = updateMarkovWordInMarkovArray([firstWord, secondWord], markovArray: markovArray)
//                                        variationArray.append(firstWord)
//                                        variationArray.append(secondWord)
//                                        
//                                        currentSectionLength += 2
//                                        
//                                        break
//                                    }
                                }
                            }
                            
                            break
                        }
                        
                    } else {
                        if printToLog {

                        print("There has been a serious error! So serious it doesn't have an error type!")
                        }
                    }
                }
            }
            if printToLog {

            print("Perform validity check of words")
            }
            if !self.checkValidityOfMarkovArray(markovArray) {
                if printToLog {

                print("All words are used up, we have to break")
                }
                break
            }
        }
        if printToLog {

            print(" ")
            print("!!!")

            for word in variationArray {
            
                print(word.word)
            }
        
            print(" ")
            print("!!!")
        }
        var variation = VariationModel(variation: variationArray)

        return variation
    }
    
    // Strip the strings into words, then re-add them as markovWords to a markovPart, then return markovParts in a markovPartsArray
    
    private func convertStringsArrayToMarkovWordArray(stringsArray:[String]) -> [MarkovPart] {
        
        let unwantedCharacterSet = NSCharacterSet(charactersInString: "(),:'“”\" ")
        var markovPartArray = [MarkovPart]()
        
        for (stringIndex, string) in stringsArray.enumerate() {
            
            let words = string.componentsSeparatedByCharactersInSet(unwantedCharacterSet)
            var markovPart = MarkovPart()
            
            var strippedWordsArray = [String]()
            
            for word in words {
                
                if !word.isEmpty {
                    strippedWordsArray.append(word)
                }
            }
            
            // We need to create an array without " ", otherwise the index in this loop could be wrong
            
            for (wordIndex, word) in strippedWordsArray.enumerate() {
                
                if !word.isEmpty {
                    
                    let markovWord = MarkovWord(word: word, index: (section: stringIndex, point: wordIndex), hasBeenUsed: false)
                    markovPart.wordsArray.append(markovWord)
                }
            }
            
            markovPartArray.append(markovPart)
        }
        
        return markovPartArray
    }
    
    private func generateRandomSeedFromLowestValueToHighestValue(lowestValue: Int, highestValue: Int) -> Int {
        
        let randomSeed = GKShuffledDistribution(lowestValue: lowestValue, highestValue: highestValue)
        return randomSeed.nextInt()
    }
    
    private func pickStartingWordsFromMarkovPart(var markovPart: MarkovPart) throws -> (firstWord: MarkovWord, secondWord: MarkovWord, thirdWord: MarkovWord) {
       
        var randomSeed = generateRandomSeedFromLowestValueToHighestValue(markovPart.wordsArray.startIndex, highestValue: markovPart.wordsArray.endIndex.predecessor())
        
        if markovPart.wordsArray[randomSeed].hasBeenUsed {
            
            throw FindStartingWordsError.UnableToFindFirstWord()
        }
        
        var firstWord = markovPart.wordsArray[randomSeed]
        firstWord.hasBeenUsed = true
        
        if randomSeed++ < markovPart.wordsArray.endIndex.predecessor() {
            
            if markovPart.wordsArray[randomSeed].hasBeenUsed {
                
                throw FindStartingWordsError.UnableToFindSecondWord(firstWord: firstWord, .WordAlreadyUsed)
            }
            
            var secondWord = markovPart.wordsArray[randomSeed]
            secondWord.hasBeenUsed = true
            
            if randomSeed++ < markovPart.wordsArray.endIndex.predecessor() {
                
                var thirdWord = markovPart.wordsArray[randomSeed]
                thirdWord.hasBeenUsed = true

                if printToLog {
                    print("1st word: \(firstWord.word) @ index: \(firstWord.index.section).\(firstWord.index.point), 2nd word: \(secondWord.word) @ index: \(secondWord.index.section).\(secondWord.index.point), 3rd word: \(thirdWord.word) @ index: \(thirdWord.index.section).\(thirdWord.index.point)")
                    print(" ")
                }

                return (firstWord, secondWord, thirdWord)
                
            } else {
                if printToLog {

                print("1st word: \(firstWord.word), 2nd word: \(secondWord.word)")
                print(" ")
                }
                throw FindStartingWordsError.UnableToFindThirdWord(firstWord: firstWord, secondWord: secondWord)
            }
            
        } else {
            if printToLog {

            print("1st word: \(firstWord.word)")
            print(" ")
            }
            throw FindStartingWordsError.UnableToFindSecondWord(firstWord: firstWord, .NoWordAvailable)
        }
        
    }
    
    private func searchForSuffixWithPrefixArrayFromMarkovPartArray(prefixArray: [MarkovWord], markovPartArray: [MarkovPart]) throws -> MarkovWord {
        
        let prefixArraySize = prefixArray.count
        let depthIndex = prefixArraySize - prefixDepth
        
        var validPrefixes = [String]()
        
        for (index, prefix) in prefixArray.enumerate() {
            
            if index >= depthIndex {
                
                validPrefixes.append(prefix.word)
            }
        }
        
        let sortedPrefixesWithSuffix = createPrefixesToDepthSizeFromProvidedText(markovPartArray, prefixesArray: validPrefixes, depth: depthIndex)
        let matchingPrefixes = findMatchingPrefixes(sortedPrefixesWithSuffix, validPrefixes: validPrefixes)
        
        do {
            
            let suffix = try pickSuffix(matchingPrefixes)
            
            return suffix
            
        } catch {
            
            throw FindSuffixWordError.UnableToFindSuffix
        }
    }
    
    private func createPrefixesToDepthSizeFromProvidedText(markovPartArray: [MarkovPart], prefixesArray: [String], depth: Int) -> [PrefixesAndSuffix] {
        
        var prefixesAndSuffixArray = [PrefixesAndSuffix]()
        
        // Look through array section by section
        
        for (partIndex, markovPart) in markovPartArray.enumerate() {
    
            // Then look through every word in the section
    
            for (index, _) in markovPart.wordsArray.enumerate() {
    
                var prefixesAndSuffix = PrefixesAndSuffix()
                
                // We create text groupings the same size as our validPrefixes, so we can compare 2 words at once if we have two prefix depth etc
    
                var lastPrefixIndex = 0
                
                for var itterator = 0; itterator < prefixesArray.count; itterator++ {
                    
                    // we make this by going off the index and then the itterator, so we get the word that index is on, then the words after from the + itterator,
                    // this allows us to work with any prefix depth
                    if index + itterator == markovPart.wordsArray.count {

                        let prefix = MarkovWord(word: "", index: (section: partIndex, point: itterator), hasBeenUsed: false)
                        prefixesAndSuffix.prefixes.append(prefix)
                        break
                        
                    } else {
                        
                        prefixesAndSuffix.prefixes.append(markovPart.wordsArray[index + itterator])
                    }
                    
                    lastPrefixIndex = itterator
                }
                
                if index + lastPrefixIndex + 1 < markovPart.wordsArray.count {
                    
                    // We only want suffixes that have not been used
                    // No need to throw an error, the array will just be smaller & handled later
                    
                    if !markovPart.wordsArray[index + lastPrefixIndex + 1].hasBeenUsed {
                       
                        let suffix = markovPart.wordsArray[index + lastPrefixIndex + 1]
                        prefixesAndSuffix.suffix = suffix
                    }
                }

                // Empty arrays are caused by hasBeenUsed words, so ignore them
                if !prefixesAndSuffix.prefixes.isEmpty {
                    
                    prefixesAndSuffixArray.append(prefixesAndSuffix)
                }
            }
        }
        
        // Print to console
        
        for tuple in prefixesAndSuffixArray {
            
            var prefixesString = String()

            for prefix in tuple.prefixes {
                
                let string = "'\(prefix.word)' @ \(prefix.index.section).\(prefix.index.point), "
                prefixesString = prefixesString + string
            }
            
            prefixesString = "Prefixes: \(prefixesString)Suffix: '\(tuple.suffix.word)' @ \(tuple.suffix.index.section). \(tuple.suffix.index.point)"
            
            //print(prefixesString)
        }

        return prefixesAndSuffixArray
    }
    
    private func findMatchingPrefixes(prefixesAndSuffix: [PrefixesAndSuffix], validPrefixes: [String]) -> [PrefixesAndSuffix] {
        
        var matchingPrefixes = [PrefixesAndSuffix]()

        for prefixesAndSuffix in prefixesAndSuffix {
            
            var matchingWords = [MarkovWord]()
            
            for (index, prefix) in prefixesAndSuffix.prefixes.enumerate() {
                
                if prefixesAndSuffix.prefixes[index].word.lowercaseString == validPrefixes[index].lowercaseString {
                    
                    matchingWords.append(prefix)
                    
                } else {
                    break
                }
            }
            
            if matchingWords.count == validPrefixes.count {
                matchingPrefixes.append(prefixesAndSuffix)
            }
        }
        if printToLog {

        print(" ")
        }
        for prefixesAndSuffix in matchingPrefixes {
            
            var prefixesString = String()

            for prefix in prefixesAndSuffix.prefixes {
                
                let string = "'\(prefix.word)' @ \(prefix.index.section).\(prefix.index.point), "
                prefixesString = prefixesString + string
            }
            
            prefixesString = "Matched Prefixes: \(prefixesString)Suffix: '\(prefixesAndSuffix.suffix.word)' @ \(prefixesAndSuffix.suffix.index.section). \(prefixesAndSuffix.suffix.index.point)"

            if printToLog {

                print(prefixesString)
            }
        }
        
        return matchingPrefixes
    }
    
    private func pickSuffix(prefixesArray: [PrefixesAndSuffix]) throws -> MarkovWord {
        
        var suffixArray = [MarkovWord]()
        var emptySuffixArray = [MarkovWord]()
        for prefixes in prefixesArray {
            
            if prefixes.suffix.word.isEmpty {
                emptySuffixArray.append(prefixes.suffix)

            } else {
                suffixArray.append(prefixes.suffix)
            }
        }
        
        if suffixArray.isEmpty {
            if printToLog {

            // THere must have only been ""
            print("Unable to find suffix")
            }
            throw FindSuffixWordError.UnableToFindSuffix
            
        } else {
            
            let randomSeed = generateRandomSeedFromLowestValueToHighestValue(suffixArray.startIndex, highestValue: suffixArray.endIndex.predecessor())
            if printToLog {

            print("Seed = \(randomSeed) word = \(suffixArray[randomSeed].word) index = \(suffixArray[randomSeed].index.section).\(suffixArray[randomSeed].index.point)")
            }
            var suffix = suffixArray[randomSeed]
            suffix.hasBeenUsed = true
            return suffix
        }
    }
    
    private func updateMarkovWordInMarkovArray(markovWords: [MarkovWord], var markovArray: [MarkovPart]) -> [MarkovPart] {
        
        for markovWord in markovWords {
            
            let sectionIndex = markovWord.index.section
            let pointIndex = markovWord.index.point
            
            var markovPart = markovArray[sectionIndex]
            markovPart.wordsArray[pointIndex] = markovWord
            markovArray[sectionIndex] = markovPart
        }
        
        return markovArray
    }
    
    private func checkValidityOfMarkovArray(markovArray: [MarkovPart]) -> Bool {
        
        for markovPart in markovArray {
            
            for word in markovPart.wordsArray {
                
                if !word.hasBeenUsed {
                    if printToLog {

                    print("There are still words to be found!")
                    }
                    return true
                }
            }
        }
        if printToLog {

        print("There are no more words to be found!")
        }
        return false
    }
    
    // MARK: - Handle errors
    
    private func handleFindStartingWordsError(error: FindStartingWordsError, var markovArray: [MarkovPart], var variationArray: [MarkovWord], var currentSectionLength: Int) -> (markovArray: [MarkovPart], variationArray: [MarkovWord], currentSectionLength: Int) {
        
        switch error {
                        
            case .UnableToFindFirstWord():
                break
                        
            case .UnableToFindSecondWord(let firstWord, let UnableToFindWordReasonError):
                        
                // If no word was found we don't do anything & try to find starting words again
                // If it failed because the word was already used we add it just to move things along
                        
                if UnableToFindWordReasonError == .WordAlreadyUsed {
                            
                    markovArray = updateMarkovWordInMarkovArray([firstWord], markovArray: markovArray)
                    variationArray.append(firstWord)
                    currentSectionLength += 1
                }
                break
                        
            case .UnableToFindThirdWord(let firstWord, let secondWord):
                markovArray = updateMarkovWordInMarkovArray([firstWord, secondWord], markovArray: markovArray)
                variationArray.append(firstWord)
                variationArray.append(secondWord)
                        
                currentSectionLength += 2
                        
                break
        }
        
        return (markovArray, variationArray, currentSectionLength)
    }
}
