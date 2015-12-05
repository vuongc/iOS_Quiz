//
//  Question.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class Question: NSObject, NSCoding {

    //MARK: Properties
    var question: String
    var answer: Int
    var answers: [String]?
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("questions")
    
    // MARK: Types
    struct PropertyKey {
        static let questionKey = "question"
        static let answerKey = "answer"
        static let answersKey = "answers"
    }
    
    // MARK: Initializer
    init?(question: String, answer: Int!, answers: [String]) {
        self.question = question
        self.answer = answer
        self.answers = answers

        super.init()
        
        if (question.isEmpty || answer < 0 || answers.count < 0) {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(question, forKey: PropertyKey.questionKey)
        aCoder.encodeInteger(answer, forKey: PropertyKey.answerKey)
        aCoder.encodeObject(answers, forKey: PropertyKey.answersKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let question = aDecoder.decodeObjectForKey(PropertyKey.questionKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let answer = aDecoder.decodeIntegerForKey(PropertyKey.answerKey) as Int
        
        let answers = aDecoder.decodeObjectForKey(PropertyKey.answersKey) as! [String]
        
        // Must call designated initializer.
        self.init(question: question, answer: answer, answers: answers)
    }
    
}
