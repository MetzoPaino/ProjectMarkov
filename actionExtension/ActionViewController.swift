//
//  ActionViewController.swift
//  actionExtension
//
//  Created by William Robinson on 19/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(
            kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: {
                (result, error) in
                                        
                                        var convertedString = result as? String
                                        
                                        if convertedString != nil {
                                            
                                            
                                            DispatchQueue.main.async {
                                                print(convertedString!)
                                                self.textView.text = convertedString

                                            }
                                        }
            })
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

    @IBAction func save() {
        
        let defaults = UserDefaults(suiteName: "group.extensiontexttaker")

        if var textArray = defaults!.object(forKey: "TextArray") as? [String] {
            
            textArray.append(textView.text)
            defaults?.set(textArray, forKey: "TextArray")
            
        } else {
            
            var textArray = [String]()
            textArray.append(textView.text)
            defaults?.set(textArray, forKey: "TextArray")
        }
        defaults?.synchronize()
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
}
