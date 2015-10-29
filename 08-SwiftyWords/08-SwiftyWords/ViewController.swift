//
//  ViewController.swift
//  08-SwiftyWords
//
//  Created by Laura Calinoiu on 27/10/15.
//  Copyright © 2015 3Smurfs. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews {
            if subview.tag == 1001{
                let btn = subview as! UIButton
                letterButtons.append(btn)
                
                btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
            }
        }
        
        loadLevel()
    }
    
    func loadLevel(){
        var clueString = ""
        var solutionsString = ""
        var letterBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt"){
            if let levelContents = try? NSString(contentsOfFile: levelFilePath, usedEncoding: nil){
                var lines = levelContents.componentsSeparatedByString("\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                
                for (index, line) in lines.enumerate(){
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index+1). \(clue)\n"
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    solutions.append(solutionWord)
                    
                    solutionsString += "\(solutionWord.characters.count) letters\n"
                    
                    let bits = answer.componentsSeparatedByString("|")
                    letterBits += bits
                }
            }
        }
        
        //configure the letters and labels
        cluesLabel.text = clueString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionsString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
        letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count{
                letterButtons[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
        
    }
    
    func letterTapped(btn: UIButton){
        currentAnswer.text! += btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitTapped(sender: UIButton) {
        if let solutionPosition = solutions.indexOf(currentAnswer.text!){
            activatedButtons.removeAll()
            
            var splitClues = answersLabel.text!.componentsSeparatedByString("\n")
            splitClues[solutionPosition] = currentAnswer.text!
            
            answersLabel.text = splitClues.joinWithSeparator("\n")
            currentAnswer.text = ""

            score++
            
            if score % 7 == 0{
                let ac = UIAlertController(title: "Well done!", message: "Ready for next level", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .Default, handler: levelUp))
                presentViewController(ac, animated: true, completion: nil)
            }
        }
    }
    
    
    func levelUp(action: UIAlertAction){
        ++level
        loadLevel()
        
        for btn in letterButtons{
            btn.hidden = false
        }
    }
    
    @IBAction func clearTapped(sender: UIButton) {
        
        currentAnswer.text = ""
        
        for btn in activatedButtons{
            btn.hidden = false
        }
        
        activatedButtons.removeAll()
    }
}

