//
//  MasterViewController.swift
//  05-WordScramble
//
//  Created by Laura Calinoiu on 22/10/15.
//  Copyright © 2015 3Smurfs. All rights reserved.
//

import UIKit
import GameplayKit

class MasterViewController: UITableViewController {
    
    var objects = [String]()
    var allWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt"){
            do{
                let startWords = try! NSString(contentsOfFile: startWordsPath, usedEncoding: nil)
                allWords = startWords.componentsSeparatedByString("\n")
            }
        }
        else {
            allWords =  ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
        startGame()
    }
    
    
    func startGame(){
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer(){
        let ac  = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default){ [unowned self, ac] _ in
            let answer = ac.textFields![0] as UITextField
            self.submitAnswer(answer.text!)
        }
        
        ac.addAction(submitAction)
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func submitAnswer(answer: String){
        let lowerAnswer = answer.lowercaseString
        if wordIsPossible(lowerAnswer){
            if wordIsOriginal(lowerAnswer){
                if wordIsReal(lowerAnswer){
                    insertAnswerInTable(lowerAnswer)
                } else {
                    let ac = UIAlertController(title: "Word not recognized", message: "You can not just made them up!", preferredStyle: .Alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        presentViewController(ac, animated: true, completion: nil)
                }
            } else {
                let ac = UIAlertController(title: "Word already in list", message: "You already have it here!", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    presentViewController(ac, animated: true, completion: nil)
                
            }
        } else {
            let ac = UIAlertController(title: "Word not possible", message: "You don't have all those letters!", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(ac, animated: true, completion: nil)
            
        }
    }
    
    func insertAnswerInTable(answer: String){
        objects.insert(answer, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func wordIsPossible(word: String) -> Bool{
        var tempWord = title!.lowercaseString
        
        for letter in word.characters {
            if let pos = tempWord.rangeOfString(String(letter)){
                if pos.isEmpty{
                    return false
                } else {
                    tempWord.removeAtIndex(pos.startIndex)
                }
            } else {
                return false
            }
        }
        
        return true
    }
    
    
    func wordIsOriginal(string: String) -> Bool{
        return !objects.contains(string)
    }
    
    func wordIsReal(word: NSString) -> Bool{
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.length)
        
        let misspelledRange = checker.rangeOfMisspelledWordInString(String(word), range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }
}

