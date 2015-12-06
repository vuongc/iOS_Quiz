//
//  Word.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/4/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class Word: NSObject, NSCoding {
  
    // MARK: Properties
    
    var english : String
    var pinyins : String
    var characters : String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("words")
    
    // MARK: Types
    
    struct PropertyKey {
        static let englishKey = "english"
        static let pinyinsKey = "pinyins"
        static let charactersKey = "characters"
    }
    
    // MARK: Initialization
    
    init?(english : String, pinyins : String, characters : String) {
        self.english = english
        self.pinyins = pinyins
        self.characters = characters
        
        super.init()
        
        if (english.isEmpty || pinyins.isEmpty || characters.isEmpty) {
            return nil
        }
    }
    
    // MARK: Methods
    
    func getTranslation(translation: String) -> String {
        if translation == "english" {
            return english
        }
        if translation == "pinyins" {
            return pinyins
        }
        return characters
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(english, forKey: PropertyKey.englishKey)
        aCoder.encodeObject(pinyins, forKey: PropertyKey.pinyinsKey)
        aCoder.encodeObject(characters, forKey: PropertyKey.charactersKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let english = aDecoder.decodeObjectForKey(PropertyKey.englishKey) as! String
        let pinyins = aDecoder.decodeObjectForKey(PropertyKey.pinyinsKey) as! String
        let characters = aDecoder.decodeObjectForKey(PropertyKey.charactersKey) as! String
        
        
        // Must call designated initializer.
        self.init(english: english, pinyins: pinyins, characters: characters)
    }
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}