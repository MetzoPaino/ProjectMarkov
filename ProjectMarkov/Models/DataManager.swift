//
//  DataModel.swift
//  ProjectMarkov
//
//  Created by William Robinson on 21/11/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import Foundation

class DataManager {
    
    var themes = [ThemeModel]()
    
    init() {
        
        loadData()
    }
    
    // MARK: - Save & Load
    
    func saveData() {
        
        print("Saving Data")

        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(themes, forKey: "Themes")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                themes = unarchiver.decodeObjectForKey("Themes") as [ThemeModel]
                if let unarchivedThemes = unarchiver.decodeObjectForKey("Themes") as? [ThemeModel] {
                    
                    print("Found Themes")
                    themes = unarchivedThemes
                    
                } else {
                    
                    print("Didn't find Themes")
                    themes = [ThemeModel]()
                }
                
                unarchiver.finishDecoding()
            }
        } else {
            
            print("No file path")
            themes = [ThemeModel]()
            
            themes.append(createTheOldManAndTheSeaTheme())
            themes.append(createHelloTheme())
            themes.append(createMrsDallowayTheme())
            themes.append(createConstellationTheme())
            themes.append(createTheOtherTheme())
            themes.append(createSacksTheme())
            themes.append(createQuestionsTheme())
            themes.append(createDirectQuotesTheme())
        }
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingString("/ProjectMarkov.plist")
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
}