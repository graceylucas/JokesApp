//
//  DataService.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import Firebase


class DataService {
    static let dataService = DataService()
    
    // Private variables that point to the JSON folder structure
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _JOKE_REF = Firebase(url: "\(BASE_URL)/jokes")

    // Public version of the above variables
    var BASE_REF: Firebase {
        return _BASE_REF
    }

    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users")
        
        return currentUser!
        
    }
    
    var JOKE_REF: Firebase{
        return _JOKE_REF
    }
    
    
    func createNewAccount(uid: String, user: Dictionary <String, String>) {

        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
}