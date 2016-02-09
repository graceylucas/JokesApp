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
    
    @IBAction func saveJoke(sender: AnyObject) {
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        
    }
}
