//
//  MainViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 19/11/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var localTextArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults(suiteName: "group.extensiontexttaker")
        defaults?.synchronize()
        
        if let textArray = defaults!.object(forKey: "TextArray") {
            
            localTextArray = textArray as! [String]
            
        } else {
            
            let textArray = [String]()
            defaults?.set(textArray, forKey: "TextArray")
            defaults?.synchronize()
        }
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

extension MainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = localTextArray[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localTextArray.count
    }
}

extension MainViewController: UITableViewDelegate {
    
    
}

