//
//  ThemeDetailViewController.swift
//  ProjectMarkov
//
//  Created by William Robinson on 03/10/2015.
//  Copyright © 2015 William Robinson. All rights reserved.
//

import UIKit

protocol NewModelViewControllerDelegate: class {
    func newModelViewControllerCreateNewThemeWithName(name: String)
}

class NewModelViewController: UIViewController, UITextViewDelegate {

    // NavBar
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var keyboardButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: NewModelViewControllerDelegate?

    let placeholderValues = (text: "Placeholder", color: UIColor.lightGrayColor())
    
    // MARK: - Setup View
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        styleView()
    }
    
    // MARK: - Style View

    func styleView() {
        
        textView.text = placeholderValues.text
        textView.textColor = placeholderValues.color
        textView.becomeFirstResponder()
        textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
    }
    
    // MARK: - IBActions

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func keyboardButtonPressed(sender: UIBarButtonItem) {
        
        if textView.isFirstResponder() {
            
            textView.resignFirstResponder()
            
        } else {
            
            textView.becomeFirstResponder()
        }
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        resignFirstResponder()
        
        dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.newModelViewControllerCreateNewThemeWithName(self.textView.text)
        }
    }
    
    // MARK: - TextView Delegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let oldText = textView.text
        let newText: NSString = (oldText as NSString).stringByReplacingCharactersInRange(range, withString: text)
        doneButton.enabled = newText.length > 0
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = placeholderValues.text
            textView.textColor = placeholderValues.color
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }

}
