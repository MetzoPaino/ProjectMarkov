//
//  ViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

protocol MotifViewControllerDelegate: class {
    func presentMarkovViewController()
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AddViewControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    weak var delegate: MotifViewControllerDelegate?

    var addViewController = AddViewController()
    
    var motifsArray = burningAirlinesGiveYouSoMuchMore

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(markovGenerator().create(inputArray:burningAirlinesGiveYouSoMuchMore))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        self.delegate?.presentMarkovViewController()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ModalAdd", sender: self)
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
        }
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! MotifCollectionViewCell
        cell.label.text = motifsArray[indexPath.row]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func savedString(string: String) {
        motifsArray.insert(string, at: 0)
        collectionView.reloadData()
    }

}
