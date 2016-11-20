//
//  CreateMotifViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 20/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CreateMotifViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions

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
        navigationController?.popViewController(animated: true)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
