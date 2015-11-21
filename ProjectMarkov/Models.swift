//
//  ThemeModel.swift
//  ProjectMarkov
//
//  Created by William Robinson on 03/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

//struct ThemeModel {
//    var name = ""
//    
//    var motifs = [MotifModel]()
//    
//    init(name: String) {
//        self.name = name
//    }
//    
////    func encodeWithCoder(aCoder: NSCoder) {
////        aCoder.encodeObject(name, forKey: "Name")
////        aCoder.encodeObject(motifs, forKey: "Motifs")
//    
//}
//
//extension ThemeModel {
//    class HelperClass: NSObject, NSCoding {
//        
//        var theme: ThemeModel?
//        
//        init(theme: ThemeModel) {
//            self.theme = theme
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
//            guard let name = aDecoder.decodeObjectForKey("name") as? String else {
//                theme = nil;
//                super.init();
//                return nil
//            }
//            
//            theme = ThemeModel(name: name)
//            
//            super.init()
//        }
//
//        func encodeWithCoder(aCoder: NSCoder) {
//            aCoder.encodeObject(theme!.name, forKey: "name")
//        }
//    }
//}

class ThemeModel: NSObject, NSCoding {
    
    let nameKey = "name"
    let motifsKey = "motifs"
    let variationsKey = "variations"

    var name = ""
    
    var motifs = [MotifModel]()
    var variations = [VariationModel]()

    init(name: String) {
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedName = aDecoder.decodeObjectForKey(nameKey) as? String {
            
            name = decodedName
            
        } else {
            name = "?!?"
        }
        
        if let decodedMotifs = aDecoder.decodeObjectForKey(motifsKey) as? [MotifModel] {
            
            motifs = decodedMotifs
        }
        
        if let decodedVariations = aDecoder.decodeObjectForKey(variationsKey) as? [VariationModel] {
            
            variations = decodedVariations
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        print("Saving Theme")
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(motifs, forKey: motifsKey)
        aCoder.encodeObject(variations, forKey: variationsKey)
    }
}

class MotifModel: NSObject, NSCoding {
    
    let textKey = "text"
    let selectedKey = "selected"
    
    var text: String
    var selected = true
    init(string: String) {
        text = string
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedText = aDecoder.decodeObjectForKey(textKey) as? String {
            
            text = decodedText
            
        } else {
            text = "?!?"
        }
        
        if let decodedSelected = aDecoder.decodeObjectForKey(selectedKey) as? Bool {
            
            selected = decodedSelected
            
        } else {
            selected = false
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        print("Saving Motif")
        aCoder.encodeObject(text, forKey: textKey)
        aCoder.encodeObject(selected, forKey: selectedKey)
    }
}

class VariationModel: NSObject, NSCoding {
    
    let displayStringKey = "displayString"
    let variationArrayKey = "variationArray"
    
    var displayString: String!
    var variation = [MarkovWord]()

    init(variation: [MarkovWord]) {
        self.variation = variation
//        displayString = createDisplayString(self.variation)
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
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedDisplayString = aDecoder.decodeObjectForKey(displayStringKey) as? String {
            
            displayString = decodedDisplayString
            
        } else {
            
            displayString = "?!?"
        }
        
        if let decodedVariationArray = aDecoder.decodeObjectForKey(variationArrayKey) as? [MarkovWord] {
            
            variation = decodedVariationArray
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        print("Saving Variation")
        aCoder.encodeObject(displayString, forKey: displayStringKey)
        aCoder.encodeObject(variation, forKey: variationArrayKey)
    }

}