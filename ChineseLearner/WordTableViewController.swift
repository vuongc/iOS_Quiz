//
//  WordTableViewController.swift
//  ChineseLearner
//
//  Created by Alex Michaux on 12/4/15.
//  Copyright © 2015 Alex Michaux. All rights reserved.
//

import UIKit

class WordTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var words = [Word]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.leftBarButtonItem = editButtonItem()
        
        if let savedWords = loadWords() {
            words += savedWords
        } else {
            loadSampleWords()
        }
        
        navigationItem.hidesBackButton = false
        self.tableView.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    }
    
    func loadSampleWords() {
        let word1 = Word(english: "Hello", pinyins: "Nín hǎo", characters: "您好")!
        let word2 = Word(english: "Goodbye", pinyins: "Zàijiàn", characters: "再见")!
        let word3 = Word(english: "Thanks", pinyins: "Xièxiè", characters: "谢谢")!
        
        words += [word1, word2, word3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "WordTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WordTableViewCell
        
        let word = words[indexPath.row]
        
        cell.englishLabel.text = word.english
        cell.pinyinsLabel.text = word.pinyins
        cell.charactersLabel.text = word.characters
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            words.removeAtIndex(indexPath.row)
            saveWords()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        }
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = UIColor.clearColor()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let wordDetailViewController = segue.destinationViewController as! WordViewController
            
            if let selectedWordCell = sender as? WordTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedWordCell)!
                let selectedWord = words[indexPath.row]
                wordDetailViewController.word = selectedWord
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new word.")
        }
    }
    
    @IBAction func unwindToWordList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? WordViewController, word = sourceViewController.word {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                words[selectedIndexPath.row] = word
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                let newIndexPath = NSIndexPath(forRow: words.count, inSection: 0)
                words.append(word)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveWords()
        }
    }
    
    // MARK: NSCoding
    
    func saveWords() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(words, toFile: Word.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save words...")
        }
    }
    
    func loadWords() -> [Word]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Word.ArchiveURL.path!) as? [Word]
    }
}
