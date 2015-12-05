//
//  QuizTableViewController.swift
//  Quiz
//
//  Created by Christopher Vuong on 12/4/15.
//  Copyright © 2015 Christopher Vuong. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {

    // MARK: Properties
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let saveQuestions = loadQuestions() {
            questions += saveQuestions
        }
        else {
            loadSampleQuestions()
        }
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "QuizTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! QuizTableViewCell

        // Configure the cell...
        let question = questions[indexPath.row]
        
        cell.questionLabel.text = question.question
        for i in 0..<question.answers!.count {
            cell.answersLabel[i].text = question.answers![i]
        }
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            questions.removeAtIndex(indexPath.row)
            saveQuestions()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            self.questions.removeAtIndex(indexPath.row)
            self.saveQuestions()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction]
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowQuestion" {
            let questionDetailViewController = segue.destinationViewController as! QuestionViewController
            
            //Get the cell that generated this segue
            if let selectedQuizCell = sender as? QuizTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedQuizCell)!
                let selectedQuestion = questions[indexPath.row]
                
                questionDetailViewController.question = selectedQuestion
            }
        }
    }

    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? QuestionViewController, question = sourceViewController.question {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing question.
                questions[selectedIndexPath.row] = question
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new question.
                let newIndexPath = NSIndexPath(forRow: questions.count, inSection: 0)
                questions.append(question)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the questions.
            saveQuestions()
        }
    }
    
    // MARK: NSCoding
    func saveQuestions() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(questions, toFile: Question.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save questions...")
        }
    }
    
    func loadQuestions() -> [Question]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Question.ArchiveURL.path!) as? [Question]
    }
    
    // MARK: Actions
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
}
