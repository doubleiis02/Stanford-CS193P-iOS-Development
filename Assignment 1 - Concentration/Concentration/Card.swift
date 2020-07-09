//
//  Card.swift
//  Concentration
//
//  Created by Jiin Kim on 7/8/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

struct Card
{
    /// Indicates whether or not the card is face up or face down
    var isFaceUp = false
    
    /// Indicates whether the card has been matched or not
    var isMatched = false
    
    /// Indicate whether the player has already checked this card before
    var hasSeen = false
    
    /// Represents the type of card (based on the emoji it has on its face)
    var identifier: Int
    
    /// Indicates how many different types of card objects exist
    static var identifierFactory = 0
    
    /// Returns a unique identifier for a new type of card that has been created
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    /// Initializes identifier propperty
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
