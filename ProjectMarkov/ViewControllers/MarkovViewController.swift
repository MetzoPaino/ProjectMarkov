//
//  MarkovViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

protocol MarkovViewControllerDelegate: class {
    func createdVariation(variation: [String])
    //func closed()

}

class MarkovViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var providedText = [String]()
    var markovArray = [String]()// markovGenerator().create(inputArray:burningAirlinesGiveYouSoMuchMore)
    weak var delegate: MarkovViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markovArray = markovGenerator().create(inputArray:providedText)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBAction

    @IBAction func retryButtonPressed(_ sender: UIButton) {
        markovArray = markovGenerator().create(inputArray:providedText)
        collectionView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.delegate?.createdVariation(variation: markovArray)
        markovArray = markovGenerator().create(inputArray:burningAirlinesGiveYouSoMuchMore)
        collectionView.reloadData()
    }
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return markovArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MotifCollectionViewCell
        cell.label.text = markovArray[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

}
