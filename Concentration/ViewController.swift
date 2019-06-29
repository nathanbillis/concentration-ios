//
//  ViewController.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return(cardButtons.count+1) / 2
    }
    
    var flipCount = 0 {
        // Count the Flips
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // Label Flip Count
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    

    // When the card is Touched
    @IBAction func touchCard(_ sender: UIButton) {
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
    func flipCard(withEmoji emoji: String,on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    
    // Update The View from the Model
    
    func updateViewFromModel() {
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
    var emojiChoices = ["🎃","👻","🎄","🍭","🎅","🌈","🍬"]
    var emoji = Dictionary<Int,String>()
    
    
    // return emoji
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        game.NewGame()
        updateViewFromModel()
    }
    
}
