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

