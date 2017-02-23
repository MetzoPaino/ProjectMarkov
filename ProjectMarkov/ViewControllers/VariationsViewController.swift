//
//  VariationsViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

class VariationsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    //var variationArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func appendVariationToArray(array: [String]) {
        
        VariationManager().appendVariationToArray(array: array)
        if collectionView != nil {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func motifEditButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteVariation(index: sender.tag)
        }
        
//        let editAction = UIAlertAction(title: "Edit", style: .`default`) { action in
//            self.editMotif(index: sender.tag)
//        }
        alertController.addAction(destroyAction)
        //alertController.addAction(editAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    func deleteVariation(index: Int) {
//        variationArray.remove(at: index)
//        collectionView.reloadData()
    }
    
    func editMotif(index: Int) {
//        let text = motifsData.motifsArray[index].motif
//        currentlyEditingIndex = index
//        performSegue(withIdentifier: "ModalEdit", sender: text)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VariationManager().variationCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MotifCollectionViewCell
        
        var string = ""
        
        let array = VariationManager().variationArrayForIndex(index:indexPath.row) //variationArray[indexPath.row]
        
        cell.optionsButton.tag = indexPath.row
        
        for text in array {
            string += text + " "
        }
        
        cell.label.text = string
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
