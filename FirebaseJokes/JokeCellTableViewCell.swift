//
//  JokeCellTableViewCell.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import Firebase


class JokeCellTableViewCell: UITableViewCell {
    
    var joke: Joke!
    var voteRef: Firebase!
    
    
    @IBOutlet weak var jokeText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalVotesLabel: UILabel!
    @IBOutlet weak var thumbVoteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically
        
        let tap = UITapGestureRecognizer(target: self, action: "voteTapped:")
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
        
        
        
    }
    
    //configureCell() sets labels and listen for a vote tap
    
    func configureCell(joke: Joke) {
        self.joke = joke
        
        
        self.jokeText.text = joke.jokeText
        self.totalVotesLabel.text = "Total votes: \(joke.jokeVotes)"
        self.usernameLabel.text = joke.username
        
        // Set "votes" as a child of the current user in Firebase and save the joke's key in votes as a boolean.
        
        voteRef = DataService.dataService.CURRENT_USER_REF.childByAppendingPath("votes").childByAppendingPath(joke.jokeKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print("thumbsUpDown")
                
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                
            } else {
                
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
            }
            
            
        })
    }
    
    func voteTapped(sender: UIGestureRecognizer) {
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                
                // addSubtractVote(), in Joke.swift, handles the vote.
                
                self.joke.addSubtractVote(true)
                
                // setValue saves the vote as true for the current user.
                // voteRef is a reference to the user's "votes" path.
                
                self.voteRef.setValue(true)
                
            } else {
                
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                self.joke.addSubtractVote(false)
                self.voteRef.removeValue()
            }
        })
        
    }
    
}






