//
//  ViewController.swift
//  Concentration
//
//  Created by Jiin Kim on 7/4/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    /// Represents a fresh game
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    /// Represents the index of the current card theme in the array emojiThemes
    lazy var currentThemeNumber = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    
    /// Starts a new game when the New Game button is activated
    @IBAction func newGame(_ sender: UIButton) {
        currentThemeNumber = Int(arc4random_uniform(UInt32(emojiThemes.count))) // Randomly sets the theme of the new game
        emojiThemes = createEmojiThemes() // Turns emojiThemes back to its original state, since emojis were removed from the array during the previous game to create new pairs of cards
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2) // game is set to be a fresh Concentration game object
        flipCountLabel.text = "Flips: 0" // Indicates that flipCount is now back to zero
        for button in cardButtons { // Flips down every card
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        }
    }
    
    /// Represents the "Flips : #" label in the View
    @IBOutlet weak var flipCountLabel: UILabel!
    
    /// Represents the "Score: #" label in the View
    @IBOutlet weak var scoreLabel: UILabel!
    
    /// Represents an array of every card button in the View
    @IBOutlet var cardButtons: [UIButton]!
    
    /// Updates View to match the Model (game stats) after a card button has been activated
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            game.flipCount += 1
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Scores: \(game.scoreCount)"
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    /// "Flips" over the card button
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) :#colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
            }
        }
    }
    
    /// Represents an array of themes
    lazy var emojiThemes = createEmojiThemes()
    
    /// Returns an array of String arrays, wheree each String array contains emojis associated with a unique theme
    func createEmojiThemes() -> [[String]] {
        var themes = [[String]]()
        themes.append(["🎃", "👻", "🐈", "🍬", "🍎", "😱", "😈", "🧚‍♂️", "🧻", "🧛🏻‍♂️"])
        themes.append(["🐶", "🐱", "🐻", "🐔", "🐙", "🐣", "🐸", "🐮", "🐰", "🐵"])
        themes.append(["⚽️", "🏀", "🏈", "⚾️", "🏐", "🎱", "🥏", "🎾", "🏓", "🏸"])
        themes.append(["🍎", "🍊", "🍇", "🍐", "🍋", "🍒", "🍑", "🍌", "🍉", "🍍"])
        themes.append(["🥰", "😗", "🧐", "🤔", "😂", "😌", "😳", "😍", "🤭", "🤧"])
        themes.append(["🍦", "🍰", "🍡", "🍪", "🍩", "🍫", "🍬", "🧁", "🍧", "🥠"])
        return themes
    }
    
    /// Keeps track of the identifier (key) that each emoji in a theme (value) corresponds to
    var emoji = [Int:String]()
    
    /// Returns the emoji associated with a specific type of card (based on its identifier)
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiThemes[currentThemeNumber].count > 0 { // sets a new emoji to correspond to the identifier if needed
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes[currentThemeNumber].count)))
            emoji[card.identifier] = emojiThemes[currentThemeNumber].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?" // return the optional's value if it exists, otherwise return "?"
    }
}

