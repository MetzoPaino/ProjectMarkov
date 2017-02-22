//
//  AddViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 04/02/2017.
//  Copyright © 2017 William Robinson. All rights reserved.
//

import UIKit

enum Mode {
    case add
    case edit
}

protocol AddViewControllerDelegate: class {
    func savedString(string: String)
    func editedString(string: String)
}

class AddViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonBottomConstraint: NSLayoutConstraint!
    

    
    weak var delegate: AddViewControllerDelegate?

    var editText: String?
    var currentMode: Mode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotifications()
        
        textView.becomeFirstResponder()
        textView.delegate = self
        
        if let editText = editText {
            textView.text = editText
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - NSNotification
    
    func addNotifications() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.receivedKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.receivedKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func receivedKeyboardNotification(_ notification: Notification) {
        
        if notification.name == NSNotification.Name.UIKeyboardDidShow {
            
            let info = (notification as NSNotification).userInfo! as Dictionary
            
            if let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
                textView.scrollIndicatorInsets = textView.contentInset
                saveButtonBottomConstraint.constant = keyboardSize.height + 16
                view.layoutIfNeeded()
            }
            
        } else if notification.name == NSNotification.Name.UIKeyboardDidHide {
            
            textView.contentInset = UIEdgeInsets.zero
            textView.scrollIndicatorInsets = textView.contentInset
        }
    }

    
    // MARK: - IBActions
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if currentMode == Mode.add {
            self.delegate?.savedString(string: textView.text)
        } else if currentMode == Mode.edit {
            self.delegate?.editedString(string: textView.text)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
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
