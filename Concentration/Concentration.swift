//
//  Concentration.swift
//  Concentration
//
//  Created by Nathan Billis on 26/12/2018.
//  Copyright © 2018 Nathan Billis. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    // Int is of type Optional
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // Check if they match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else{
                // Either Two or No Cards are Face up
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            
            // two diffrent cards in memory
            cards += [card, card]
        }
        //Shuffle Cards
        cards = shuffleCards(with: cards)
    }
    
    func shuffleCards(with cardArray: [Card]) -> [Card] {
        var Cards = cardArray
        var tempCards = Cards
        
        for cardnumber in 0..<Cards.count{
            let randomIndex = Int(arc4random_uniform(UInt32(Cards.count)))
            tempCards[cardnumber] = Cards.remove(at: randomIndex)
        }
        return tempCards
    }
    
    func NewGame() {
        for index in 0..<cards.count{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards = shuffleCards(with: cards)
    }
}
