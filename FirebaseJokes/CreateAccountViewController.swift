//
//  CreateAccountViewController.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Collects data from fields to create new user
    @IBAction func createAccount(sender: AnyObject) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" {
            
            
            // Sets email and password for new user(s)
            
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    // If there's a signup error, this prompts user to try again
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    
                    
                } else {
                    
                    
                    // Otherwise, this creates a user and logs user in
                    
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                        
                        err, authData in
                        
                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
                        
                        
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                        
                        })
                        
                        
                        // Store user ID
                        
                        NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                        
                        
                        // Allow user to enter the app now that they have a profile and are logged in
                        
                        self.performSegueWithIdentifier("New user is logged in", sender: nil)
                    }
                })
                
                        
                        } else {
                        
                        signupErrorAlert("Oops!", message: "Double check your email and password. Then try again.")
                        
                    }
                    
    }
                @IBAction func cancelCreateAccount(sender: AnyObject) {
                    self.dismissViewControllerAnimated(true, completion: {})
                }
    
    
    // Function that sends a prompt if user signup in didn't work
    func signupErrorAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
}
