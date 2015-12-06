//
//  WordViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/4/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class WordViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var pinyinTextField: UITextField!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var characterTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    var word : Word?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        englishTextField.delegate = self
        pinyinTextField.delegate = self
        characterTextField.delegate = self
        
        if let word = word {
            navigationItem.title = word.english
            englishTextField.text = word.english
            pinyinTextField.text = word.pinyins
            characterTextField.text = word.characters
        }
        
        checkValidWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidWord()
        navigationItem.title = englishTextField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidWord() {
        let english = englishTextField.text ?? ""
        let pinyins = pinyinTextField.text ?? ""
        let characters = characterTextField.text ?? ""
        
        saveButton.enabled = !english.isEmpty && !pinyins.isEmpty && !characters.isEmpty
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let english = englishTextField.text ?? ""
            let pinyins = pinyinTextField.text ?? ""
            let characters = characterTextField.text ?? ""
            
            word = Word(english: english, pinyins: pinyins, characters: characters)
        }
    }
}

