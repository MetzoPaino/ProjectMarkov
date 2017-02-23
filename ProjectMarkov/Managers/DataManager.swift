//
//  DataManager.swift
//  ProjectMarkov
//
//  Created by William Robinson on 23/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import Foundation

class DataManager {
    
    var variations: [[String]]
    
    required init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        let path = paths[0] + "/ProjectMarkov.plist"
        
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                
                if let decodedVariations = unarchiver.decodeObject(forKey: "Variations") as? [[String]] {
                    
                    variations = decodedVariations
                    
                } else {
                    variations = [[String]]()
                }
                
                unarchiver.finishDecoding()
            } else {
                variations = [[String]]()
            }
        } else {
            
            variations = [[String]]()
        }
    }
    
    // MARK: - Save & Load
    
    func saveData() {
        
        print("Saving Data")
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(variations, forKey: "Variations")
        
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func dataFilePath() -> String {
        return documentsDirectory() + "/ProjectMarkov.plist"
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
}
