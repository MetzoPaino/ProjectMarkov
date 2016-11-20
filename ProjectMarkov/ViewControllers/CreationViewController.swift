//
//  CreationViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 20/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    var strings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ShuffleGenerator().createString(stringArray: strings)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        label.text = ShuffleGenerator().createString(stringArray: strings)
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
