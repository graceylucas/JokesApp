//
//  JokesFeedTableViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class JokesFeedTableViewController: UITableViewController {
    
    var jokes = [Joke] ()
    
    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
            UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observeEventType() method. Firebase data is retrieved by attaching an asynchronous listener to a database reference. This awesome method is not only called in viewDidLoad() upon navigation to JokesFeedTableViewController.swift, it is called whenever there is a change in the jokes side of our database.
        
        DataService.dataService.JOKE_REF.observeEventType(.Value, withBlock: { snapshot in
            
            
            // The snapshot is a current look at our jokes data.
            
            print(snapshot.value)
            
            self.jokes = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our jokes array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let joke = Joke(key: key, dictionary: postDictionary)
                        
                        // Shows newest jokes first
                        self.jokes.insert(joke, atIndex: 0)
                        
                        
                    }
                    
                }
            }
            
            // updates the tableview
            self.tableView.reloadData()
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return jokes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let joke = jokes[indexPath.row]
        
        // We are using a custom cell
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("JokeCellTableViewCell") as? JokeCellTableViewCell {
            
            // Send the single joke to configureCell() in JokeCellTableViewCell
            
            cell.configureCell(joke)
            
            return cell
            
        } else {
            
            return JokeCellTableViewCell()
            
        }
    }
    
    
}