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
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    lazy var currentThemeNumber = Int(arc4random_uniform(UInt32(emojiThemes.count)))
    
    @IBAction func newGame(_ sender: UIButton) {
        currentThemeNumber = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiThemes = createEmojiThemes()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: 0"
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
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
    
    lazy var emojiThemes = createEmojiThemes()
    
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
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiThemes[currentThemeNumber].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemes[currentThemeNumber].count)))
            emoji[card.identifier] = emojiThemes[currentThemeNumber].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

