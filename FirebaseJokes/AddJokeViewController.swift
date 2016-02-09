//
//  AddJokeViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class AddJokeViewController: UIViewController {
    
    
    var currentUsername:String = ""

    
    @IBOutlet weak var jokeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Get username of person adding joke
        DataService.dataService.CURRENT_USER_REF.observeEventType(FEventType.Value , withBlock: {  (snapshot) -> Void in
            let currentUser = snapshot.value.objectForKey("username") as! String
            
            print("Username: \(currentUser)")
            self.currentUsername = currentUser
            
        }) { error in
            print(error.description)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    // When saveJoke() is called, newJoke dictionary is created using the text from the jokeField, 0 for the current number of votes, and the current user’s username as the author. These values are assigned to their respective ids and sent over to createNewJoke() in DataService for saving.
    
    
    @IBAction func saveJoke(sender: AnyObject) {
        
        let jokeText = jokeField.text
        
        
        if jokeText != "" {
            
            
            // Build the new Joke.
            // AnyObject is needed because of the votes of type Int.
            
            let newJoke: Dictionary<String, AnyObject> = [
            
                "jokeText": jokeText!,
                "votes": 0,
                "author": currentUsername
            ]
            
            // Send it over to DataService
            
            DataService.dataService.createNewJoke(newJoke)
            
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }

        }
        
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
    }
}
