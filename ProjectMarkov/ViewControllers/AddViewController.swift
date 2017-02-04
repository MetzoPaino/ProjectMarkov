//
//  AddViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    func savedString(string: String)
}

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    weak var delegate: AddViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        textView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.delegate?.savedString(string: textView.text)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
    }

    @IBAction func tapGesturePressed(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        tapGestureRecognizer.isEnabled = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tapGestureRecognizer.isEnabled = true
    }

}
