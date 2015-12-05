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
    
    var questions = [Question]()
    var questionNumber = Int()
    var answerNumber = Int()
    var userScore: Int = 0
    var numberOfQuestionsDid: Int = 1
    var defaultColor: UIColor = UIColor(red:0.40, green:0.80, blue:1.00, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    func setAllButtonTitleInDefaultColor(defaultColor: UIColor) {
        for i in 0..<Buttons.count {
            Buttons[i].backgroundColor = defaultColor
        }
    }
    
    func controlButtonActionFunction(index: Int!) {
        if (answerNumber == index) {
            userScore += 1
            setAllButtonTitleInDefaultColor(defaultColor)
            pickRandomQuestion()
        }
        else {
            userScore -= 1
            setAllButtonTitleInDefaultColor(defaultColor)
            Buttons[index].backgroundColor = UIColor.redColor()
        }
        numberOfQuestionsDid += 1
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
        }
        else {
            self.performSegueWithIdentifier("ShowScoreBoard", sender: self)
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowScoreBoard" {
            let scoreBoardDetailViewController = segue.destinationViewController as! ScoreBoardViewController
            
            scoreBoardDetailViewController.scoreValue = "\(userScore)/\(numberOfQuestionsDid)"
        }
    }
    
    // MARK: NSCoding
    func loadQuestions() -> [Question]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Question.ArchiveURL.path!) as? [Question]
    }

}

