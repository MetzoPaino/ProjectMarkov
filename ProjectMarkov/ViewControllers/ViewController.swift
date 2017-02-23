//
//  ViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

protocol MotifViewControllerDelegate: class {
    func presentMarkovViewControllerWithMotifs(motifs: [String])
}

class MotifData {
    
    var motifsArray = [(motif: String, turnedOn: Bool)]()
    
    init(motifs: [String]) {

        for string in motifs {
            
            motifsArray.append((motif: string, turnedOn: true))
        }
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createButton: UIButton!

    weak var delegate: MotifViewControllerDelegate?

    var addViewController = AddViewController()
    
    var motifsData = MotifData.init(motifs:burningAirlinesGiveYouSoMuchMore)
    var currentlyEditingIndex: Int?

    var flowLayout: UICollectionViewFlowLayout {
        return self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }

    func styleView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - IBAction
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        var motifArray = [String]()
        
        for motif in motifsData.motifsArray {
            
            if motif.turnedOn == true {
                motifArray.append(motif.motif)
            }
        }
        
        self.delegate?.presentMarkovViewControllerWithMotifs(motifs: motifArray)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ModalAdd", sender: self)
    }

    @IBAction func motifEditButtonPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteMotif(index: sender.tag)
        }
        
        let editAction = UIAlertAction(title: "Edit", style: .`default`) { action in
            self.editMotif(index: sender.tag)
        }
        alertController.addAction(destroyAction)
        alertController.addAction(editAction)

        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    func deleteMotif(index: Int) {
        motifsData.motifsArray.remove(at: index)
        collectionView.reloadData()
    }
    
    func editMotif(index: Int) {
        let text = motifsData.motifsArray[index].motif
        currentlyEditingIndex = index
        performSegue(withIdentifier: "ModalEdit", sender: text)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ModalAdd" {
            let navigationController = segue.destination as! UINavigationController
            addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
            addViewController.currentMode = Mode.add

        } else if segue.identifier == "ModalEdit" {
            
            let string = sender as! String
            
            let navigationController = segue.destination as! UINavigationController
            addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
            addViewController.editText = string
            addViewController.currentMode = Mode.edit
        }
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motifsData.motifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MotifCollectionViewCell
        
        let test = motifsData.motifsArray[indexPath.row]
        
        cell.label.text = test.motif
        cell.optionsButton.tag = indexPath.row
        cell.turnedOn = test.turnedOn
        
        if test.turnedOn == true {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.blue
        }
        
        cell.configureCell(turnedOn: test.turnedOn)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        motifsData.motifsArray[indexPath.row].turnedOn = !motifsData.motifsArray[indexPath.row].turnedOn
        toggleCreateButton()
        collectionView.reloadData()
    }
    
    // MARK: - Toggle
    
    func toggleCreateButton() {
        
        var enabled = false
        
        for motif in motifsData.motifsArray {
            
            if motif.turnedOn == true {
                enabled = true
                break
            }
        }
        
        if createButton.isEnabled != enabled {
            createButton.isEnabled = enabled
            
            if createButton.isEnabled == true {
                createButton.backgroundColor = .blue
            } else {
                createButton.backgroundColor = .gray
            }
        }
    }
    
    // MARK: - Add Delegate
    
    func savedString(string: String) {
        
        if string != "" {
            motifsData.motifsArray.insert((motif: string, turnedOn: true), at: 0)
            collectionView.reloadData()
        }
    }
    
    func editedString(string: String) {
        
        if string != "" {
            
            if let currentlyEditingIndex = currentlyEditingIndex {
                motifsData.motifsArray[currentlyEditingIndex].motif = string
            }
            currentlyEditingIndex = nil
            collectionView.reloadData()
        }
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var division = 2.0 as CGFloat
        
        let horizontalClass = self.traitCollection.horizontalSizeClass;
        let verticalClass = self.traitCollection.verticalSizeClass;
        
        if horizontalClass == UIUserInterfaceSizeClass.regular && verticalClass == UIUserInterfaceSizeClass.regular {
            
            division = division + 1.0
        }
        
        return CGSize(width: view.frame.size.width / division - 16, height: view.frame.size.width / division)
    }
}
