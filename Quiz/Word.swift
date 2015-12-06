//
//  Word.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class Word: NSObject, NSCoding {

    //MARK: Enum
    enum WordType {
        case English
        case Pinyin
        case Character
    }
    
    //MARK: Properties
    var word: [Int: [String]]
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("words")
    
    // MARK: Types
    struct PropertyKey {
        static let wordKey = "word"
    }
    
    // MARK: Initializer
    init?(word: [Int: [String]]) {
        self.word = word

        super.init()
        
        if (word.isEmpty) {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(word, forKey: PropertyKey.wordKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let word = aDecoder.decodeObjectForKey(PropertyKey.wordKey) as! [Int: [String]]
        
        // Must call designated initializer.
        self.init(word: word)
    }
    
}
