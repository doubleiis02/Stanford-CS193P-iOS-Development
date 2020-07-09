//
//  Concentration.swift
//  Concentration
//
//  Created by Jiin Kim on 7/8/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

class Concentration
{
    /// Represents an Array of every card in the game; cards are referenced based on their index number for this Array
    var cards = [Card]()
    
    /// Represents the index of the card that is the only card currently face up, if such a card exists
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    /// Represents the current number of flips in a game
    var flipCount = 0
    
    /// Represents the current score of a game
    var scoreCount = 0
    
    /// Updates the score and the status of each card after a card has been flipped
    func chooseCard(at index: Int) {
        if !cards[index].isMatched { // function does nothing if the chosen card has already been matched
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { // only one card was face up
                if cards[matchIndex].identifier == cards[index].identifier { // the two cards match; add 2 points to score
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else { // the two cards do not match
                    // deduct a point for each card that the player has already seen
                    if cards[matchIndex].hasSeen == true {
                        scoreCount -= 1
                    }
                    if cards[index].hasSeen == true {
                        scoreCount -= 1
                    }
                    // player has seen the cards, now any mismatch in the future involving these cards will result in a point deduction
                    cards[matchIndex].hasSeen = true
                    cards[index].hasSeen = true
                }
                cards[index].isFaceUp = true // the Controller will flip over the card to show the card that the player chose
                indexOfOneAndOnlyFaceUpCard = nil // since two cards are now up, this must be nil
            } else { // either no cards or two cards were face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false // now every card is face down
                }
                cards[index].isFaceUp = true // the one card chosen is now face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    /// Initializes all the cards in the game and then shuffles their order
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // two cards per pair, both have the same values
        }
        
        /// Shuffles the cards in array cards
        cards.shuffle()
    }
}
