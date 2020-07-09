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
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    var scoreCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else {
                    print("match was not made")
                    print("the hasSeen of 1st card was \(cards[matchIndex].hasSeen)")
                    if cards[matchIndex].hasSeen == true {
                        scoreCount -= 1
                    }
                    print("the hasSeen of 2nd card was \(cards[index].hasSeen)")
                    if cards[index].hasSeen == true {
                        scoreCount -= 1
                    }
                    cards[matchIndex].hasSeen = true
                    cards[index].hasSeen = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or two cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        /// Shuffles the cards in array cards
        cards.shuffle()
    }
}
