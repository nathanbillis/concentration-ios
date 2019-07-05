//
//  ViewController.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return(cardButtons.count+1) / 2
    }
    
    private(set) var flipCount = 0 {
        // Count the Flips
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    // Label Flip Count
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    

    // When the card is Touched
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            if !game.cards[cardNumber].isMatched{
                flipCount += 1
                }
        }
        else{
            print("ERROR: card not in range")
        }
    }
    
    

    // Function to Flip the Cards
    private func flipCard(withEmoji emoji: String,on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    
    // Update The View from the Model
    
    private func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) :#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    
    // Emoji Array    
    private var emojiChoices = "🎃👻🎄🍭🎅🌈🍬"
    
    private var emoji = Dictionary<Card,String>()
    
    
    // return emoji
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices.count > 0 {
                let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    
    @IBAction private func newGame(_ sender: UIButton) {
        flipCount = 0
        game.NewGame()
        updateViewFromModel()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}
