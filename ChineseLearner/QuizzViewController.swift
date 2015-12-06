//
//  QuizzViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/5/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet var answersButton: [UIButton]!

    @IBOutlet weak var questionStack: UIStackView!

    @IBOutlet var mainView: UIView!
    var words = [Word]()
    var questionNumber = 0
    var answerType = "characters"
    var questionType = "english"
    var rightAnswer = 0
    var errors = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        if let listWords = loadWords() {
            if listWords.count > 3 {
                words += listWords
            }
            else {
                loadSampleWords()
            }
        }
        else {
            loadSampleWords()
        }
        questionNumber = 0
        errors = 0
        words.shuffleInPlace()
        prepareQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadUI() {
        questionLabel.backgroundColor = UIColor.whiteColor()
        questionLabel.layer.cornerRadius = 1
        questionLabel.layer.borderWidth = 1
        questionLabel.layer.borderColor = UIColor.blackColor().CGColor
        questionLabel.layer.shadowColor = UIColor.blackColor().CGColor
        questionLabel.layer.shadowOffset = CGSizeMake(2, 2)
        questionLabel.layer.shadowRadius = 2
        questionLabel.layer.shadowOpacity = 0.5
     }
    
    func loadSampleWords() {
        let word1 = Word(english: "Hello", pinyins: "Nín hǎo", characters: "您好")!
        let word2 = Word(english: "Goodbye", pinyins: "Zàijiàn", characters: "再见")!
        let word3 = Word(english: "Thanks", pinyins: "Xièxiè", characters: "谢谢")!
        let word4 = Word(english: "Test", pinyins: "TestPinyins", characters: "TestCharacters")!
        
        words += [word1, word2, word3, word4]
    }

    func prepareQuestion() {
        var usedIndex = [Int]()
        var randomizedIndex = 0

        usedIndex += [questionNumber]
        questionLabel.text = words[questionNumber].getTranslation(questionType)

        for i in 0..<4 {
            randomizedIndex = randUnusedIndex(usedIndex)
            usedIndex += [randomizedIndex]
            answersButton[i].setTitle(words[randomizedIndex].getTranslation(answerType), forState: .Normal)
        }
        
        rightAnswer = randRange(0, upper: 3)
        answersButton[rightAnswer].setTitle(words[questionNumber].getTranslation(answerType), forState: .Normal)
    }
    
    func randUnusedIndex(usedIndex: [Int]) -> Int {
        var randomizeNumber = randRange(0, upper: words.count - 1)
        
        while usedIndex.contains(randomizeNumber) {
            randomizeNumber = randRange(0, upper: words.count - 1)
        }
        return randomizeNumber
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    // MARK: Actions
    
    @IBAction func answerOne(sender: UIButton) {
        if rightAnswer == 0 {
            questionNumber += 1
            if (questionNumber < words.count) {
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 0.0
                })
                
                prepareQuestion()
                
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 1.0
                })
            }
            else {
                self.performSegueWithIdentifier("ShowResult", sender: nil)
            }
        }
        else {
            errors += 1
        }
    }
    
    @IBAction func answerTwo(sender: UIButton) {
        if rightAnswer == 1 {
            questionNumber += 1
            if (questionNumber < words.count) {
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 0.0
                })

                prepareQuestion()
                
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 1.0
                })
            }
            else {
                self.performSegueWithIdentifier("ShowResult", sender: nil)
            }
        }
        else {
            errors += 1
        }

    }
    
    @IBAction func answerThree(sender: UIButton) {
        if rightAnswer == 2 {
            questionNumber += 1
            if (questionNumber < words.count) {
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 0.0
                })

                prepareQuestion()
                
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 1.0
                })
            }
            else {
                self.performSegueWithIdentifier("ShowResult", sender: nil)
            }
        }
        else {
            errors += 1
        }

    }
    
    @IBAction func answerFour(sender: UIButton) {
        if rightAnswer == 3 {
            questionNumber += 1
            if (questionNumber < words.count) {
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 0.0
                })

                prepareQuestion()
                
                UIView.animateWithDuration(0.5, animations: {
                    self.questionStack.alpha = 1.0
                })
            }
            else {
                self.performSegueWithIdentifier("ShowResult", sender: nil)
            }
        }
        else {
            errors += 1
        }

    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let resultViewController = segue.destinationViewController as! ResultViewController
        
        if segue.identifier == "ShowResult" {
            resultViewController.errors = errors
            resultViewController.numberOfQuestions = words.count
        }
    }


    
    // MARK: NSCoding
    
    func loadWords() -> [Word]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Word.ArchiveURL.path!) as? [Word]
    }
}
