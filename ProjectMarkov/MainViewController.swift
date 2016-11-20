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
    var localVariationsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLocalData()
        tableView.reloadData()
    }
    
    func updateLocalData() {
        
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowCompose" {
            
            let controller = segue.destination as! CreationViewController
            controller.strings = localTextArray
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ShowAdd", sender: self)
    }

    @IBAction func composeButtonPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "ShowCompose", sender: self)
    }
}

extension MainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = localTextArray[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localTextArray.count
    }
}

extension MainViewController: UITableViewDelegate {
    
    
}

