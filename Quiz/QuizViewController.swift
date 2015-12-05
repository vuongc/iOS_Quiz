//
//  QuizViewController.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    
    var questions = [Question]()
    var questionNumber = Int()
    var answerNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideStatusLabel()
        if let saveQuestions = loadQuestions() {
            questions += saveQuestions
        }
        else {
            loadSampleQuestions()
        }
        pickRandomQuestion()
    }

    func loadSampleQuestions() {
        
        questions = [
            Question(question: "Where is Brian", answer: 1, answers: ["In the bathroom", "In the kitchen", "In the living room", "In the garage"])!,
            Question(question: "Toto", answer: 1, answers: ["i", "o", "u", "a"])!,
            Question(question: "Tata", answer: 3, answers: ["i", "o", "u", "a"])!,
            Question(question: "Titi", answer: 0, answers: ["i", "o", "u", "e"])!
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    func hideStatusLabel() {
        statusLabel.hidden = true
    }
    
    func showStatusLabel() {
        statusLabel.hidden = false
    }
    
    func controlButtonActionFunction(index: Int!) {
        if (answerNumber == index) {
            statusLabel.text = "You are right !"
            showStatusLabel()
            pickRandomQuestion()
        }
        else {
            statusLabel.text = "You are wrong !"
            showStatusLabel()
        }
    }
    
    @IBAction func Button1Action(sender: AnyObject) {
        controlButtonActionFunction(0)
    }
    
    @IBAction func Button2Action(sender: AnyObject) {
        controlButtonActionFunction(1)
    }
    
    @IBAction func Button3Action(sender: AnyObject) {
        controlButtonActionFunction(2)
    }
    
    @IBAction func Button4Action(sender: AnyObject) {
        controlButtonActionFunction(3)
    }
    
    func pickRandomQuestion() {
        if questions.count > 0 {
            questionNumber = random() % questions.count
            QuestionLabel.text = questions[questionNumber].question
            
            answerNumber = questions[questionNumber].answer
            
            for i in 0..<Buttons.count {
                Buttons[i].setTitle(questions[questionNumber].answers![i], forState: UIControlState.Normal)
            }
            
            questions.removeAtIndex(questionNumber)
            hideStatusLabel()
        }
        else {
            statusLabel.text = "You have done all the questions !"
            showStatusLabel()
        }
    }
    
    // MARK: NSCoding
    func loadQuestions() -> [Question]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Question.ArchiveURL.path!) as? [Question]
    }

}

