//
//  NewWordViewController.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class NewWordViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var englishLabel: UITextField!
    @IBOutlet weak var pinyinLabel: UITextField!
    @IBOutlet weak var characterLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var word: Word?
    var answersIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        englishLabel.delegate = self
        
        var englishWordTab = word![Word.WordType.English.hashValue]
        var pinyinWordTab = word![Word.WordType.Pinyin.hashValue]
        var charracterWordTab = word![Word.WordType.Character.hashValue]
        
        if let word = word {
            englishLabel.text = englishWordTab
            pinyinLabel.text = englishWordTab[englishWordTab.count - 1]
            characterLabel.text = word[2].word.values
        }
        
        checkValidQuestionObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidQuestionObject()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidQuestionObject() {
        let questionText = questionLabel.text ?? ""
        saveButton.enabled = !questionText.isEmpty
        for i in 0..<4 {
            let answer = answersLabel[i].text ?? ""
            
            saveButton.enabled = saveButton.enabled && !answer.isEmpty
        }
        let answerText = answerLabel.text ?? ""
        saveButton.enabled = !answerText.isEmpty
    }


    // MARK: - Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let questionValue = questionLabel.text ?? ""
            let answers = [answersLabel[0].text!, answersLabel[1].text!, answersLabel[2].text!, answersLabel[3].text!]
            
            for i in 0..<4 {
                if answerLabel.text == answersLabel[i].text {
                    answersIndex = i
                }
            }

            question = Question(question: questionValue, answer: answersIndex, answers: answers)
        }
    }

}
